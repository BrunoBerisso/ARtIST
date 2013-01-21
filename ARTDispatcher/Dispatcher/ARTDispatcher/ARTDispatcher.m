//
//  ARTDispatcher.m
//  Dispatcher
//
//  Created by Bruno Berisso on 21/01/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import "ARTDispatcher.h"

@implementation ARTDispatcher

+ (void)dispatch:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue afterDelay:(int64_t)delayInSeconds async:(BOOL)async {
    if (block) {
        
        dispatch_queue_t queueToUse = queue;
        if (queueToUse == NULL)
            queueToUse = dispatch_get_main_queue();
        
        if (delayInSeconds != 0) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, queueToUse, block);
        } else {
            if (async)
                dispatch_async(queueToUse, block);
            else
                dispatch_sync(queue, block);
        }
    }
}

+ (void)dispatchOnMain:(dispatch_block_t)block {
    [self dispatch:block onQueue:dispatch_get_main_queue() afterDelay:0 async:YES];
}

+ (void)dispatchOnBackground:(dispatch_block_t)block {
    [self dispatch:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) afterDelay:0 async:YES];
}

+ (void)dispatch:(dispatch_block_t)block afterDelay:(int64_t)delayInSeconds {
    [self dispatch:block onQueue:dispatch_get_main_queue() afterDelay:delayInSeconds async:YES];
}

@end
