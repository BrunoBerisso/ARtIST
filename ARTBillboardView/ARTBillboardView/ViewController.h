//
//  ViewController.h
//  ARTBillboardView
//
//  Created by Bruno Berisso on 4/5/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *labelTextTextField;
@property (strong, nonatomic) IBOutlet UITextField *timeIntervalTextField;


- (IBAction)addLabelAction:(id)sender;
- (IBAction)startAnimationAction:(id)sender;
- (IBAction)stopAnimationAction:(id)sender;

@end
