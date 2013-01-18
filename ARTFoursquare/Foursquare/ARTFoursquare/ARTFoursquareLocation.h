//
//  ARTFoursquareLocation.h
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface ARTFoursquareLocation : NSObject

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *cc;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *crossStreet;
@property (nonatomic) NSUInteger distance;
@property (nonatomic, retain) NSDecimalNumber *lat;
@property (nonatomic, retain) NSDecimalNumber *lng;
@property (nonatomic) NSUInteger postalCode;
@property (nonatomic, retain) NSString *state;

- (ARTFoursquareLocation *)initWithData:(NSDictionary *)data;
- (CLLocationCoordinate2D)toCLLocation;

@end
