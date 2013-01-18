//
//  KCFoursquareCategory.h
//  KonamiCore
//
//  Created by Bruno Berisso on 06/11/12.
//
//

#import <Foundation/Foundation.h>

//{
    //                                      icon = "https://foursquare.com/img/categories/nightlife/bar.png";
    //                                      id = 4bf58dd8d48988d116941735;
    //                                      name = Bar;
    //                                      parents =                             (
    //                                                                             "Nightlife Spots"
    //                                                                             );
    //                                      pluralName = Bars;
    //                                      primary = 1;
    //                                      shortName = Bar;
    //                                  }

@interface KCFoursquareCategory : NSObject

@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *parents;
@property (nonatomic, retain) NSString *pluralName;
@property (nonatomic) BOOL primary;
@property (nonatomic, retain) NSString *shortName;

- (KCFoursquareCategory *)initWithData:(NSDictionary *)data;

@end
