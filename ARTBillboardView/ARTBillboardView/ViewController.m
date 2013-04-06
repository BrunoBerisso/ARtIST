//
//  ViewController.m
//  ARTBillboardView
//
//  Created by Bruno Berisso on 4/5/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import "ViewController.h"
#import "ARTBillboardView.h"

@interface ViewController ()

@end

@implementation ViewController {
    ARTBillboardView *_billboardView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add some long text
    self.labelTextTextField.text = @"Test Test Test Test Test Test Test Test Test Test Test Test";
    
    _billboardView = [[ARTBillboardView alloc] initWithFrame:CGRectMake(20, 342, 170, 0.0)];
    _billboardView.startAnimationOnLayout = NO;
    _billboardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_billboardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addLabelAction:(id)sender {
    [self.view endEditing:YES];
    
    if (self.labelTextTextField.text.length == 0)
        return;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 12)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor redColor];
    label.text = self.labelTextTextField.text;
    
    CGRect frame = _billboardView.frame;
    frame.size.height += 12;
    _billboardView.frame = frame;
    
    [_billboardView addLabel:label];
}

- (IBAction)startAnimationAction:(id)sender {
    if (self.timeIntervalTextField.text.length != 0)
        _billboardView.animationInterval = [self.timeIntervalTextField.text floatValue];
        
    [_billboardView startAnimationTimer];
}

- (IBAction)stopAnimationAction:(id)sender {
    [_billboardView stopAnimationTimer];
}
@end
