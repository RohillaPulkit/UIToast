//
//  UIToastView.m
//  UIToast
//
//  Created by Pulkit Rohilla on 16/03/17.
//  Copyright © 2017 PulkitRohilla. All rights reserved.
//

#import "UIToastView.h"

@implementation UIToastView{

    NSTimer *toastTimer;
}

const static int tagLbl = 10;
const static int tagView = 101;

const static float fontSizeLbl = 14.0f;
const static float viewCornerRadius = 6.0f;
const static float alphaBackgorund = 0.65f;

const static float defaultPadding = 8.0f;
const static float constantBottomSpacing = 25.0f;

const static float fadeAnimationDuration = 0.25;
const static float timerTimeInterval = 1.0;

-(id)initWithText:(NSString *)message{
    
    self = [super init];
    
    if (self) {
        
        UILabel *lblMessage = [[UILabel alloc] init];
        lblMessage.text = message;
        lblMessage.textColor = [UIColor whiteColor];
        lblMessage.tag = tagLbl;
        lblMessage.translatesAutoresizingMaskIntoConstraints = NO;
        lblMessage.font = [UIFont systemFontOfSize:fontSizeLbl];
        lblMessage.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lblMessage];

        [self.layer setCornerRadius:viewCornerRadius];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:alphaBackgorund]];
        [self setUserInteractionEnabled:NO];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setTag:tagView];
    }
    
    return self;
}

-(void)show{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    BOOL toastShown = [window viewWithTag:tagView];
    
    if (!toastShown) {
        
        [window addSubview:self];
        
        if (toastTimer) {
            
            [toastTimer invalidate];
        }
        
        toastTimer = [NSTimer scheduledTimerWithTimeInterval:timerTimeInterval
                                                      target:[NSBlockOperation blockOperationWithBlock:
                                                              ^{
                                                                  CATransition *animation = [CATransition animation];
                                                                  animation.type = kCATransitionFade;
                                                                  animation.duration = fadeAnimationDuration;
                                                                  animation.delegate = self;
                                                                  
                                                                  [self.layer addAnimation:animation forKey:nil];
                                                                  
                                                                  self.hidden = YES;
                                                                  
                                                              }]
                                                    selector:@selector(main)
                                                    userInfo:nil
                                                     repeats:NO];
    }
}

-(void)updateConstraints{

    UILabel *lblMessage = [self viewWithTag:tagLbl];

    NSDictionary *dictViews = @{ @"lblMessage" : lblMessage, @"view" : self};
    NSDictionary *viewMetrics = @{@"padding" : [NSNumber numberWithFloat:defaultPadding]};
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[lblMessage]-(padding)-|"
                                                                             options:0
                                                                             metrics:viewMetrics
                                                                               views:dictViews];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[lblMessage]-(padding)-|"
                                                                             options:0
                                                                             metrics:viewMetrics
                                                                               views:dictViews];

    NSArray *horizontalSuperConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=padding)-[view]-(>=padding)-|"
                                                                             options:0
                                                                             metrics:viewMetrics
                                                                               views:dictViews];
    
    [self.superview addConstraint: [NSLayoutConstraint constraintWithItem:self.superview
                                                      attribute:NSLayoutAttributeCenterX
                                                      relatedBy:0
                                                         toItem:self
                                                      attribute:NSLayoutAttributeCenterX
                                                     multiplier:1
                                                       constant:0]];
    
    
    [self.superview addConstraint: [NSLayoutConstraint constraintWithItem:self.superview
                                                                attribute:NSLayoutAttributeBottomMargin
                                                                relatedBy:0
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:constantBottomSpacing]];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    [self.superview addConstraints:horizontalSuperConstraints];
    
    [super updateConstraints];

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if (flag) {
        
        [self removeFromSuperview];
    }
}

@end
