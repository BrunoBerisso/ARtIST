//
//  KCFoursquareCategory.m
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import "KCFoursquareCategory.h"

@implementation KCFoursquareCategory

- (KCFoursquareCategory *)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:data];
    }
    
    return self;
}

@end
