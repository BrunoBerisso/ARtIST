//
//  ARTViewController.m
//  Foursquare
//
//  Created by Bruno Berisso on 18/01/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import "ARTViewController.h"
#import "ARTFoursquare.h"

@interface ARTViewController () <BZFoursquareRequestDelegate>
@end

@implementation ARTViewController

- (void)dealloc {
    [_clientIdTextField release];
    [_clientCallbackTextField release];
    [_responseTextView release];
    [super dealloc];
}

- (IBAction)getVenuesAction:(id)sender {
    [self.view endEditing:YES];
    
    [ARTFoursquare setClientId:self.clientIdTextField.text withCallback:self.clientCallbackTextField.text];
    self.responseTextView.text = @"Loading...";
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"37.7, -122.4" forKey:@"ll"];
    [ARTFoursquare startRequestWithPath:@"venues/search" HTTPMethod:@"GET" parameters:params delegate:self];
}

#pragma mark - ARTFoursquare Delegate

-(void)requestDidFinishLoading:(BZFoursquareRequest *)request{
    self.responseTextView.text = [request.response description];
}

-(void)request:(BZFoursquareRequest *)request didFailWithError:(NSError *)error {
    self.responseTextView.text = [error description];
}

@end
