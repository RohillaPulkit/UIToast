//
//  UIToastView.h
//  UIToast
//
//  Created by Pulkit Rohilla on 16/03/17.
//  Copyright © 2017 PulkitRohilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToastView : UIView <CAAnimationDelegate>

-(id)initWithText:(NSString *)message;
-(void)show;

@end
