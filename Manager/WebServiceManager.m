//
//  WebServiceManager.m
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import "WebServiceManager.h"
#import "HttpRequestElement.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation WebServiceManager
+(instancetype)getWebServiceInstance
{
    static long pred;
    static id shared = nil;
    dispatch_once (&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

-(instancetype)initUniqueInstance
{
    return [super init];
}

#pragma mark - WebService Methods
+(NSData *)hitPOSTRequest :(HttpRequest *)httpRequest withError : (NSError **)error
{
    __block NSData *responseData;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:httpRequest.requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSHTTPURLResponse *response = nil;
    [request setHTTPMethod:@"POST"];
    
    [self setHeaderIn:request with:httpRequest];
    [self setBodyIn:request with:httpRequest];
    
    if (IS_OS_8_OR_LATER)
    {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          responseData = data;
                                          dispatch_semaphore_signal(semaphore);
                                      }];
        [task resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    else
    {
        //Check for NSError
        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return responseData;
}

+(NSData *)hitGETRequest :(HttpRequest *)httpRequest withError : (NSError **)error
{
    __block NSData *responseData;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:httpRequest.requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSHTTPURLResponse *response = nil;
    [request setHTTPMethod:@"GET"];
    
    [self setHeaderIn:request with:httpRequest];
    
    if (IS_OS_8_OR_LATER)
    {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          responseData = data;
                                          dispatch_semaphore_signal(semaphore);
                                      }];
        
        [task resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    else
    {
        //Check for NSError
        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return responseData;
}


#pragma mark - Set Header And Body WebServiceRequest
+(void)setHeaderIn :(NSMutableURLRequest *)request with:(HttpRequest *)httpRequest
{
    NSMutableArray *headerData = httpRequest.requestHeaderArray;
    if (headerData != nil)
    {
        NSInteger headerDataSize = [headerData count];
        for (int i = 0; i < headerDataSize; i++)
        {
            HttpRequestElement *httpRequestElement = headerData[i];
            if (httpRequestElement != nil)
            {
                [request setValue: httpRequestElement.value forHTTPHeaderField:httpRequestElement.key];
            }
        }
    }
}

+(void)setBodyIn :(NSMutableURLRequest *)request with:(HttpRequest *)httpRequest
{
    [request setHTTPBody:httpRequest.requestBodyData];
}
@end
