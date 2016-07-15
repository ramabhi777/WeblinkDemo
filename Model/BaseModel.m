//
//  BaseModel.m
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(id) initWithBaseResponse:(NSDictionary *)responseDict
{
    NSDictionary *dict = [responseDict objectForKey:@"responseStatus"];
    
    self.statusCode = [(NSNumber *)[dict objectForKey:@"statusCode"] integerValue];
    self.message = [dict objectForKey:@"message"];
    self.errorTypeCode = [(NSNumber *)[dict objectForKey:@"errorTypeCode"] integerValue];
    self.errorType = [dict objectForKey:@"errorType"];
    
    return self;
}

@end