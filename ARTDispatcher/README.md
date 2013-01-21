ARTDispatcher
==========
ARTDispatcher is a shorthand for run blocks through the *dispatch_* function family.

Provide
-----------
There is only one static class, ARTDispatcher with the methods:

        + (void)dispatch:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue afterDelay:(int64_t)delayInSeconds async:(BOOL)async;
        
        + (void)dispatchOnMain:(dispatch_block_t)block;
        + (void)dispatchOnBackground:(dispatch_block_t)block;
        + (void)dispatch:(dispatch_block_t)block afterDelay:(int64_t)delayInSeconds;


Require
-----------
This will work along the *dispatch_* methods work (that's iOS > 4 and OSX > 10.6)

Contraints
--------------
None
