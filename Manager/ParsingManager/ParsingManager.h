//
//  ParsingManager.h
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingManager : NSObject
+ (ParsingManager *) getInstance;

+(NSData *) parseDataFromDictionary:(NSDictionary *)requestDict error:(NSError **)pError;
+(NSDictionary *) parseJsonFromWebService:(NSData *)pResponseData error:(NSError **)pError;
@end
