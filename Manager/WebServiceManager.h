//
//  WebServiceManager.h
//  WeblinkDemo
//
//  Created by Abhishek Shukla on 13/12/15.
//  Copyright © 2015 InnovationM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import <UIKit/UIKit.h>

#define ATTRIBUTE_ALLOC __attribute__((unavailable("alloc not available")))
#define ATTRIBUTE_INIT __attribute__((unavailable("init not available")))
#define ATTRIBUTE_NEW __attribute__((unavailable("new not available")))
#define ATTRIBUTE_COPY __attribute__ ((unavailable("copy not available")))

@interface WebServiceManager : NSObject

+(instancetype)getWebServiceInstance;
+(instancetype)alloc ATTRIBUTE_ALLOC;
-(instancetype)init ATTRIBUTE_INIT;
+(instancetype)new ATTRIBUTE_NEW;
+(instancetype)copy ATTRIBUTE_COPY;

// WebService Methods
+(NSData *)hitPOSTRequest :(HttpRequest *)httpRequest withError : (NSError **)error;
+(NSData *)hitGETRequest :(HttpRequest *)httpRequest withError : (NSError **)error;

@end
