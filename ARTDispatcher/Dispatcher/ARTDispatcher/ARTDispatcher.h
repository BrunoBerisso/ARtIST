//
//  ARTDispatcher.h
//  Dispatcher
//
//  Created by Bruno Berisso on 21/01/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARTDispatcher : NSObject

+ (void)dispatch:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue afterDelay:(int64_t)delayInSeconds async:(BOOL)async;

+ (void)dispatchOnMain:(dispatch_block_t)block;
+ (void)dispatchOnBackground:(dispatch_block_t)block;
+ (void)dispatch:(dispatch_block_t)block afterDelay:(int64_t)delayInSeconds;

@end
