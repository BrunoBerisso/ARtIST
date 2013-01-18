//
//  KCFoursquareLocation.m
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import "KCFoursquareLocation.h"

@implementation KCFoursquareLocation

- (KCFoursquareLocation *)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:data];
    }
    
    return self;
}

- (CLLocationCoordinate2D)toCLLocation {
    return CLLocationCoordinate2DMake([self.lat doubleValue], [self.lng doubleValue]);
}

@end
