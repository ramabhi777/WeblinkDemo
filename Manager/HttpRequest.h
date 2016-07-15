//
//  HttpRequest.h
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

@property (strong, nonatomic) NSMutableArray *requestHeaderArray;
@property (strong, nonatomic) NSData * requestBodyData;
@property (strong, nonatomic) NSURL *requestUrl;

-(id)initWithHeaderAndBody :(NSDictionary *)body error :(NSError **)error;
-(id) setURL :(NSString *)url;

@end
