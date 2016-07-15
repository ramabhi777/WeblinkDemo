//
//  HttpRequest.m
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import "HttpRequest.h"
#import "HttpRequestElement.h"
#import "ParsingManager.h"

@implementation HttpRequest
{
    HttpRequestElement *httpRequestElement;
}
@synthesize requestHeaderArray;
@synthesize requestBodyData;
@synthesize requestUrl;

-(id)initWithHeaderAndBody :(NSDictionary *)body error :(NSError **)error
{
    requestHeaderArray = [[NSMutableArray alloc] init];
    if (body != nil)
    {
        requestBodyData = [ParsingManager parseDataFromDictionary:body error:error];
    }
    
    httpRequestElement = [[HttpRequestElement alloc] init];
    httpRequestElement.key = @"Content-Type";
    httpRequestElement.value = @"application/json";
    [requestHeaderArray addObject:httpRequestElement];
    
    return self;
}

-(id) setURL :(NSString *)url
{
    requestUrl = [NSURL URLWithString:url];
    
    return self;
}

@end
