//
//  KCFoursquare.m
//  KonamiCore
//
//  Created by Bruno Berisso on 29/10/12.
//
//

#import "KCFoursquare.h"

#define kFoursquareAccessTokenKey      @"KonamiCORE_Foursquare_Access_Token_Key"
#define KCFoursquareErrorDomain        @"com.KonamiCore.KCFoursquare"

/********************************************************************************************************************************************/
#pragma mark - BZFoursquare Session Delegate
/********************************************************************************************************************************************/

typedef void(^DelegateSuccessCallback)(void);
typedef void(^DelegateErrorCallback)(NSError *error);

@interface KCFoursquareSessionDelegate : NSObject <BZFoursquareSessionDelegate>

+ (KCFoursquareSessionDelegate *)delegateWithSuccess:(DelegateSuccessCallback)successHandler andError:(DelegateErrorCallback)errorHandler;

@end

@implementation KCFoursquareSessionDelegate {
    DelegateSuccessCallback successCallback;
    DelegateErrorCallback errorCallback;
}

+ (KCFoursquareSessionDelegate *)delegateWithSuccess:(DelegateSuccessCallback)successHandler andError:(DelegateErrorCallback)errorHandler {
    KCFoursquareSessionDelegate *sessionDelegate = [[KCFoursquareSessionDelegate alloc] init];
    sessionDelegate->successCallback = [successHandler copy];
    sessionDelegate->errorCallback = [errorHandler copy];
    return [sessionDelegate autorelease];
}

- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare {
    //Save the access token so we don't ask for permision every time the apps run. This value is deleted on logout
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

@interface KCFoursquareSessionDelegate (KCFoursquareAlertDelegate) <UIAlertViewDelegate>
@end

@implementation KCFoursquareSessionDelegate (KCFoursquareAlertDelegate)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
        [KCFoursquare.session startAuthorization];
    else {
        if (errorCallback) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:USER_DENIED_ACCESS_ERROR, NSLocalizedFailureReasonErrorKey, ACCESS_ERROR_MSG, NSLocalizedDescriptionKey, nil];
            NSError *error = [NSError errorWithDomain:KCFoursquareErrorDomain code:0 userInfo:userInfo];
            errorCallback(error);
        } else
            [self autorelease];
    }
}

@end

/********************************************************************************************************************************************/
/********************************            BZFoursquare Session Delegate      *************************************************************/
/********************************************************************************************************************************************/

@implementation KCFoursquare {
    KCFoursquareSessionDelegate *sessionDelegate;
}

+ (void)startRequestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters delegate:(id<BZFoursquareRequestDelegate>)delegate {
    [self startRequestWithPath:path HTTPMethod:HTTPMethod parameters:parameters delegate:delegate authMessage:FOURSQUARE_LOGIN];
}

+ (void)startRequestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod parameters:(NSDictionary *)parameters delegate:(id<BZFoursquareRequestDelegate>)delegate authMessage:(NSString *)message {
    if (self.session.isSessionValid) {
        BZFoursquareRequest *request = [self.session requestWithPath:path HTTPMethod:HTTPMethod parameters:parameters delegate:delegate];
        [request start];
    } else {
        self.session.sessionDelegate = [KCFoursquareSessionDelegate delegateWithSuccess:^{
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
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Foursquare" message:message delegate:self.session.sessionDelegate cancelButtonTitle:CANCEL_TITLE otherButtonTitles:OK, nil] autorelease];
        [alert show];
    }
}

#pragma mark - BZFoursquare session management

+ (BZFoursquare *)session {
    static BZFoursquare *session = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[BZFoursquare alloc] initWithClientID:FOURSQUARE_CLIENT_ID callbackURL:FOURSQUARE_CALLBACK_URL];
        session.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kFoursquareAccessTokenKey];
    });
    
    return session;
}


@end
