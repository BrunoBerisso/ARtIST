//
//  ARTFoursquare.m
//  KonamiCore
//
//  Created by Bruno Berisso on 29/10/12.
//
//

#import "ARTFoursquare.h"

#define kFoursquareAccessTokenKey      @"Foursquare_Access_Token_Key"
#define ARTFoursquareErrorDomain        @"com.NoName.ARTFoursquare"

NSString *const ARTFoursquareUserDenyAccessError = @"User denied the access";
NSString *const ARTFoursquareAccessErrorMessage = @"Can't access to your Foursquare account";
NSString *const ARTFoursquareLoginMessage = @"You are not logged in to Foursquare. Do you want to login now?";

/********************************************************************************************************************************************/
#pragma mark - BZFoursquare Session Delegate
/********************************************************************************************************************************************/

typedef void(^DelegateSuccessCallback)(void);
typedef void(^DelegateErrorCallback)(NSError *error);

@interface ARTFoursquareSessionDelegate : NSObject <BZFoursquareSessionDelegate>

+ (ARTFoursquareSessionDelegate *)delegateWithSuccess:(DelegateSuccessCallback)successHandler andError:(DelegateErrorCallback)errorHandler;

@end

@implementation ARTFoursquareSessionDelegate {
    DelegateSuccessCallback successCallback;
    DelegateErrorCallback errorCallback;
}

+ (ARTFoursquareSessionDelegate *)delegateWithSuccess:(DelegateSuccessCallback)successHandler andError:(DelegateErrorCallback)errorHandler {
    ARTFoursquareSessionDelegate *sessionDelegate = [[ARTFoursquareSessionDelegate alloc] init];
    sessionDelegate->successCallback = [successHandler copy];
    sessionDelegate->errorCallback = [errorHandler copy];
    return [sessionDelegate autorelease];
}

- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare {
    //Save the access token so we don't ask for permision every time the apps run. This value should be deleted when the user change (logout)
    [[NSUserDefaults standardUserDefaults] setObject:foursquare.accessToken forKey:kFoursquareAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (successCallback)
        successCallback();
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo {
    if (errorCallback) {
        NSError *error = [NSError errorWithDomain:nil code:0 userInfo:errorInfo];
        errorCallback(error);
    }
}

- (void)dealloc {
    [successCallback release];
    successCallback = nil;
    [errorCallback release];
    errorCallback = nil;
    [super dealloc];
}

@end

/********************************************************************************************************************************************/
#pragma mark - UIAlertView Delegate
/********************************************************************************************************************************************/

@interface ARTFoursquareSessionDelegate (ARTFoursquareAlertDelegate) <UIAlertViewDelegate>
@end

@implementation ARTFoursquareSessionDelegate (ARTFoursquareAlertDelegate)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
        [ARTFoursquare.session startAuthorization];
    else {
        if (errorCallback) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(ARTFoursquareUserDenyAccessError, nil), NSLocalizedFailureReasonErrorKey, NSLocalizedString(ARTFoursquareAccessErrorMessage, nil), NSLocalizedDescriptionKey, nil];
            NSError *error = [NSError errorWithDomain:ARTFoursquareErrorDomain code:0 userInfo:userInfo];
            errorCallback(error);
        } else
            [self autorelease];
    }
}

@end

/********************************************************************************************************************************************/
/********************************            BZFoursquare Session Delegate      *************************************************************/
/********************************************************************************************************************************************/

@implementation ARTFoursquare {
    ARTFoursquareSessionDelegate *sessionDelegate;
}

+ (void)startRequestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters delegate:(id<BZFoursquareRequestDelegate>)delegate {
    [self startRequestWithPath:path HTTPMethod:HTTPMethod parameters:parameters delegate:delegate authMessage:NSLocalizedString(ARTFoursquareLoginMessage, nil)];
}

+ (void)startRequestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters delegate:(id<BZFoursquareRequestDelegate>)delegate authMessage:(NSString *)message {
    if (self.session.isSessionValid) {
        BZFoursquareRequest *request = [self.session requestWithPath:path HTTPMethod:HTTPMethod parameters:parameters delegate:delegate];
        [request start];
    } else {
        self.session.sessionDelegate = [ARTFoursquareSessionDelegate delegateWithSuccess:^{
            BZFoursquareRequest *request = [self.session requestWithPath:path HTTPMethod:HTTPMethod parameters:parameters delegate:delegate];
            [request start];
            
            [self.session.sessionDelegate autorelease];
            self.session.sessionDelegate = nil;
        } andError:^(NSError *error){
            [self.session.sessionDelegate autorelease];
            self.session.sessionDelegate = nil;
            
            if ([delegate respondsToSelector:@selector(request:didFailWithError:)])
                [delegate request:nil didFailWithError:error];
        }];
        
        [self.session.sessionDelegate retain];
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Foursquare" message:message delegate:self.session.sessionDelegate cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Ok", nil), nil] autorelease];
        [alert show];
    }
}

#pragma mark - BZFoursquare session management

static NSString *_clientId = nil;
static NSString *_clientCallback = nil;

+ (void)setClientId:(NSString *)clientId withCallback:(NSString *)clientCallback {
    [_clientId release];
    _clientId = nil;
    _clientId = [clientId retain];
    
    [_clientCallback release];
    _clientCallback = nil;
    _clientCallback = [clientCallback retain];
}

+ (BOOL)shouldHandleUrl:(NSURL *)url {
    return _clientCallback.length > 0 && [[url absoluteString] hasPrefix:_clientCallback];
}

+ (BZFoursquare *)session {
    static BZFoursquare *session = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[BZFoursquare alloc] initWithClientID:_clientId callbackURL:_clientCallback];
        session.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kFoursquareAccessTokenKey];
    });
    
    return session;
}


@end
