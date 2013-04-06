//
//  ARTBillBoardView.h
//  iTunesHeaderTest
//
//  Created by Bruno Berisso on 4/2/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Overview:
 
 The ARTBillboardView animte UILabel objects how's text does not fit in the label view rect. The labels wich has all his text visible will not animate. The resulting behavior is
 exactly the same as the header view in the iOS Music app when the name of the artist or album does not fit in the header.
 
 The logic is simple. A timer fire a selector every 'animationInterval' seconds. When the selector start it's check for labels with texts larger than the labels rect. It creates
 a new UILabel with (almost all) the same value attributes of the original label but with the 'width' set to hold the entire text. This new label is placed like this:
 
  _____________
 | ____________|________ _______________
 ||long label  |        |original label |
 | --------------------- ---------------
 |             |
 |_____________|
 
 The animation only moves both labels to the original position an then stops other 'animationInterval' seconds. The cool thin is that if tow labels that should be animated has diferent
 lenght the animation duration is adjust for the both labels animates at the same velocity.
 
 The method 'addLabel' is a helper to add a UILabel as subview, adding labels as usual is also supported.
 
 */

@interface ARTBillboardView : UIView

/* If YES starts the animation timer automaticaly on every layout, else the timer should be started by calling 'startAnimationTimer'. Default YES */
@property (nonatomic,assign) BOOL startAnimationOnLayout;

/* The time interval between animations. Defaul 3.0 */
@property (nonatomic,assign) NSTimeInterval animationInterval;

/* The animation velocity in pixels/seconds. Defaul 45.0 */
@property (nonatomic,assign) CGFloat animationVelocity;

/* Add a label to the billboard beneath the last label. The width of the label will be set to the billboard width. Call this method in the middle of animation has no effect*/
- (void)addLabel:(UILabel *)label;

/* Start the animation manually */
- (void)startAnimationTimer;

/* Stop animation repetition (cancel the timer) until next call to layout, in the case that 'startAnimationOnLayout == YES', or a call to 'startAnimationTimer' */
- (void)stopAnimationTimer;

@end
