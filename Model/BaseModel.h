//
//  BaseModel.h
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic) NSInteger statusCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic) NSInteger errorTypeCode;
@property (nonatomic, strong) NSString *errorType;

-(id) initWithBaseResponse:(NSDictionary *)responseDict;
@end
