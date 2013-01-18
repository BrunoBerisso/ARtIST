//
//  KCFoursquare.h
//  KonamiCore
//
//  Created by Bruno Berisso on 29/10/12.
//
//

#import <Foundation/Foundation.h>
#import "BZFoursquare.h"

@interface ARTFoursquare : NSObject

+ (void)startRequestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters delegate:(id<BZFoursquareRequestDelegate>)delegate;
+ (void)startRequestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters delegate:(id<BZFoursquareRequestDelegate>)delegate authMessage:(NSString *)message;

+ (void)setClientId:(NSString *)clientId withCallback:(NSString *)clientCallback;
+ (BOOL)shouldHandleUrl:(NSURL *)url;

+ (BZFoursquare *)session;

@end
