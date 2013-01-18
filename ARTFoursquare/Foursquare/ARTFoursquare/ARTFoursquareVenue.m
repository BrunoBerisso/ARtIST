//
//  ARTFoursquareVenue.m
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import "ARTFoursquareVenue.h"

@implementation ARTFoursquareVenue

- (id)initWithData:(NSDictionary *)data {
    self = [self init];
    
    if (self) {
        self.beenHere = [[[data valueForKey:@"beenHere"] valueForKey:@"count" ] integerValue];
        self.id = [data valueForKey:@"id"];
        self.name = [data valueForKey:@"name"];
        self.specials = [data valueForKey:@"specials"];
        self.verified = [[data valueForKey:@"verified"] boolValue];
        
        NSDictionary *contacInfo = [data valueForKey:@"contact"];
        self.contactFormattedPhone = [contacInfo valueForKey:@"formattedPhone"];
        self.contactPhone = [contacInfo valueForKey:@"phone"];
        
        NSDictionary *likesInfo = [data valueForKey:@"likes"];
        self.likesCount = [[likesInfo valueForKey:@"count"] integerValue];
        self.likesGroups = [likesInfo valueForKey:@"groups"];
        
        NSDictionary *statsInfo = [data valueForKey:@"stats"];
        self.checkinsCount = [[statsInfo valueForKey:@"checkinsCount"] integerValue];
        self.tipCount = [[statsInfo valueForKey:@"tipsCount"] integerValue];
        self.usersCount = [[statsInfo valueForKey:@"usersCount"] integerValue];
        
        self.categories = [NSMutableArray array];
        for (NSDictionary *categoryData in [data valueForKey:@"category"]) {
            ARTFoursquareCategory *category = [[ARTFoursquareCategory alloc] initWithData:categoryData];
            [self.categories addObject:category];
            [category release];
        }
        
        NSDictionary *locationData = [data valueForKey:@"location"];
        self.location = [[[ARTFoursquareLocation alloc] initWithData:locationData] autorelease];
    }
    
    return self;
}

- (void)dealloc {
    self.id = nil;
    self.name = nil;
    self.specials = nil;
    self.contactPhone = nil;
    self.contactFormattedPhone = nil;
    self.likesGroups = nil;
    
    [super dealloc];
}

@end
