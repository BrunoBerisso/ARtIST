//
//  ARTViewController.h
//  Foursquare
//
//  Created by Bruno Berisso on 18/01/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *clientIdTextField;
@property (retain, nonatomic) IBOutlet UITextField *clientCallbackTextField;
@property (retain, nonatomic) IBOutlet UITextView *responseTextView;

- (IBAction)getVenuesAction:(id)sender;

@end
