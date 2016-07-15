//
//  TaskManager.m
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import "TaskManager.h"
#import "HttpRequest.h"
#import "WebServiceManager.h"
#import "ParsingManager.h"
#import "BaseModel.h"

@implementation TaskManager

- (void) main
{
    @autoreleasepool
    {
        [self getList];
    }
}

-(void)getList
{
    NSError *error = nil;
    //    NSMutableDictionary *ruDictionary = [[NSMutableDictionary alloc] init];
    //Populating HttpRequest Model class with Header and Body
    HttpRequest *httpRequest = [[HttpRequest alloc] initWithHeaderAndBody:nil error:&error];
    if (error != nil)
    {
//        [self processError:error];
        return;
    }
    
    [httpRequest setURL:[self getUrl]];
    // Send HTTP Request
    NSData * data = [WebServiceManager hitGETRequest:httpRequest withError:&error];
    if (error != nil)
    {
//        [self processError:error];
        return;
    }
    //Parsing response JSON
    NSDictionary *baseResponseDict = [ParsingManager parseJsonFromWebService:data error:&error];
    if (error != nil)
    {
//        [self processError:error];
        return;
    }
    
    BaseModel *baseModelObj = [[BaseModel alloc]initWithBaseResponse:baseResponseDict];
    
    if(baseModelObj.statusCode != 0)
    {
//        [self.delegate handleError:baseModelObj];
        //        [self.delegate handleNoTrackieeList];
        return;
    }
    NSDictionary *responseDict = [baseResponseDict objectForKey:@"responseData"];
    
}

-(NSString *)getUrl
{
    return @"";
}

@end
