//
//  ParsingManager.m
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import "ParsingManager.h"

@implementation ParsingManager

static ParsingManager *sharedInstance = nil;

/*
 * ParsingManager manager singleton instance method
 */

+ (ParsingManager *) getInstance
{
    @synchronized(self)
    {
        if(sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

// NSData To NSDictionary
+(NSDictionary *) parseJsonFromWebService:(NSData *)pResponseData error:(NSError **)pError
{
    NSDictionary* json;
    if (pResponseData != nil)
    {
        json = [NSJSONSerialization JSONObjectWithData:pResponseData
                                               options:kNilOptions
                                                 error:pError];
    }
    else
    {
        json = nil;
    }
    
    return json;
}

// Handling parsing for different WebService Requests
+(NSData *) parseDataFromDictionary:(NSDictionary *)requestDict error:(NSError **)pError
{
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:requestDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:pError];
    
    return dataFromDict;
}

@end
