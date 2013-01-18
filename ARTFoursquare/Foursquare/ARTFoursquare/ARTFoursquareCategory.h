//
//  ARTFoursquareCategory.h
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import <Foundation/Foundation.h>

@interface ARTFoursquareCategory : NSObject

@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *parents;
@property (nonatomic, retain) NSString *pluralName;
@property (nonatomic) BOOL primary;
@property (nonatomic, retain) NSString *shortName;

- (ARTFoursquareCategory *)initWithData:(NSDictionary *)data;

@end
