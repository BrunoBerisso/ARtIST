//
//  ARTFoursquareCategory.m
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import "ARTFoursquareCategory.h"

@implementation ARTFoursquareCategory

- (ARTFoursquareCategory *)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:data];
    }
    
    return self;
}

@end
