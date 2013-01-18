//
//  ARTFoursquareVenue.h
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import <Foundation/Foundation.h>
#import "ARTFoursquareCategory.h"
#import "ARTFoursquareLocation.h"

@interface ARTFoursquareVenue : NSObject

@property (nonatomic) NSInteger beenHere;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) BOOL verified;
@property (nonatomic, retain) NSArray *specials;

//Contact
@property (nonatomic, retain) NSString *contactPhone;
@property (nonatomic, retain) NSString *contactFormattedPhone;

//Likes
@property (nonatomic) NSInteger likesCount;
@property (nonatomic, retain) NSArray *likesGroups;

//Stats
@property (nonatomic) NSInteger checkinsCount;
@property (nonatomic) NSInteger tipCount;
@property (nonatomic) NSInteger usersCount;

@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) ARTFoursquareLocation *location;

- (id)initWithData:(NSDictionary *)data;

@end
