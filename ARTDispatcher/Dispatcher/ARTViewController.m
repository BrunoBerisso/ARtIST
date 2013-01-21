//
//  ARTViewController.m
//  Dispatcher
//
//  Created by Bruno Berisso on 21/01/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import "ARTViewController.h"
#import "ARTDispatcher.h"


@implementation ARTViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [ARTDispatcher dispatchOnMain:^{
        self.textView.text = @"Dispatcher will dispatch block in...";
        
        for (int i = 5; i > 0; i--) {
            [ARTDispatcher dispatch:^{
                [ARTDispatcher dispatchOnMain:^{
                    self.textView.text = [self.textView.text stringByAppendingFormat:@"\n %d", i];
                }];
            } afterDelay:2*(5 - i)];
        }
        
        [ARTDispatcher dispatch:^{
            self.textView.text = @"Dispatched";
        } afterDelay:10];
    }];
}

- (void)dealloc {
    [_textView release];
    [super dealloc];
}
@end
