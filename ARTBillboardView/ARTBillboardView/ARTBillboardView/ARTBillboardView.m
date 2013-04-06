//
//  ARTBillBoardView.m
//  iTunesHeaderTest
//
//  Created by Bruno Berisso on 4/2/13.
//  Copyright (c) 2013 Bruno Berisso. All rights reserved.
//

#import "ARTBillboardView.h"
#import <QuartzCore/QuartzCore.h>

#define LABEL_SEPARATOR_STRING              @"      "
#define DEFAULT_ANIMATION_VELOCITY          45      //pixels/seconds
#define DEFAULT_ANIMATION_INTERVAL          3.0     //seconds

@implementation ARTBillboardView {
    NSTimer *_timer;
    BOOL _animating;
    BOOL _stoped;
}

#pragma mark - Init methods

- (void)privateInit {
    _timer = nil;
    _animating = NO;
    _stoped = NO;
    
    //Set default values
    self.startAnimationOnLayout = YES;
    self.animationInterval = DEFAULT_ANIMATION_INTERVAL;
    self.animationVelocity = DEFAULT_ANIMATION_VELOCITY;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self privateInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self privateInit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.clipsToBounds = YES;
    
    if (self.startAnimationOnLayout)
        [self startAnimationTimer];
}

#pragma mark - Public methods

- (void)addLabel:(UILabel *)label {
    if (_animating)
        return;
    
    CGFloat newYPos = 0;
    
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            newYPos += v.frame.size.height;
        }
    }
    
    CGRect frame = label.frame;
    frame.origin.x = 0;
    frame.origin.y = newYPos;
    frame.size.width = self.frame.size.width;
    label.frame = frame;
    
    [self addSubview:label];
}

- (void)startAnimationTimer {
    _stoped = NO;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (!_animating && !_timer)
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.animationInterval target:self selector:@selector(startBillboardAnimation:) userInfo:nil repeats:NO];
}

- (void)stopAnimationTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _stoped = YES;
}

#pragma mark - Animation

- (UILabel *)longLabelWithLabel:(UILabel *)label text:(NSString *)text andWidth:(CGFloat)widht {
    UILabel *longLabel = [[UILabel alloc] initWithFrame:label.frame];
    
    //If the backgroundColor is nil the result is a [UIColor blackColor] as background
    if (label.backgroundColor)
        longLabel.backgroundColor = label.backgroundColor;
    
    longLabel.textColor = label.textColor;
    longLabel.textAlignment = label.textAlignment;
    longLabel.shadowColor = label.shadowColor;
    longLabel.lineBreakMode = label.lineBreakMode;
    longLabel.numberOfLines = label.numberOfLines;
    longLabel.highlightedTextColor = label.highlightedTextColor;
    longLabel.font = label.font;
    longLabel.text = text;
    
    CGRect frame = longLabel.frame;
    frame.size.width = widht;
    longLabel.frame = frame;
    
    return longLabel;
}

- (void)startBillboardAnimation:(NSTimer *)timer {
    _animating = YES;
    
    NSMutableArray *labelsToAnimate = [NSMutableArray array];
    NSMutableArray *longLabelsToAnimate = [NSMutableArray array];
    CGSize infinitWidthSize = CGSizeMake(INFINITY, 0);
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            CGSize labelSize = label.frame.size;
            
            infinitWidthSize.height = labelSize.height;
            CGFloat textLenght = [label.text sizeWithFont:label.font constrainedToSize:infinitWidthSize lineBreakMode:NSLineBreakByTruncatingTail].width;
            
            //If the text doesn't fit this label should be animated
            if (textLenght > labelSize.width) {
                [labelsToAnimate addObject:label];
                
                //Create a long version of the label
                NSString *longText = [label.text stringByAppendingString:LABEL_SEPARATOR_STRING];
                CGFloat width = textLenght + [LABEL_SEPARATOR_STRING sizeWithFont:label.font constrainedToSize:infinitWidthSize lineBreakMode:NSLineBreakByTruncatingTail].width;
                UILabel *longLabel = [self longLabelWithLabel:label text:longText andWidth:width];
                
                //Move the original label to the end of the long label
                CGRect frame = label.frame;
                frame.origin.x = longLabel.frame.size.width;
                label.frame = frame;
                
                [longLabelsToAnimate addObject:longLabel];
                [self addSubview:longLabel];
            }
        }
    }
    
    //When this counter is == 0 the animations are done and we should restart the timer
    __block NSUInteger animationCounts = [longLabelsToAnimate count];
    
    for (UILabel *longLabel in longLabelsToAnimate) {
        
        //Calculate the duration of the animarion so different label size animate at the same velocity
        NSTimeInterval duration = longLabel.frame.size.width / self.animationVelocity;
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = longLabel.frame;
            frame.origin.x -= frame.size.width;
            longLabel.frame = frame;
            
            int labelIdx = [longLabelsToAnimate indexOfObject:longLabel];
            UILabel *label = [labelsToAnimate objectAtIndex:labelIdx];
            
            frame = label.frame;
            frame.origin.x = 0;
            label.frame = frame;
        } completion:^(BOOL finished) {
            [longLabel removeFromSuperview];
            if (finished && --animationCounts == 0) {
                if (!_stoped)
                    _timer = [NSTimer scheduledTimerWithTimeInterval:self.animationInterval target:self selector:@selector(startBillboardAnimation:) userInfo:nil repeats:NO];
                _animating = NO;
            }
        }];
    }
}

@end
