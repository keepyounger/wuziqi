//
//  NextStepColorView.m
//  wuziqi
//
//  Created by lixy on 16/1/20.
//  Copyright © 2016年 lixy. All rights reserved.
//

#import "NextStepColorView.h"

@implementation NextStepColorView

- (void)setIsWhite:(BOOL)isWhite
{
    _isWhite = isWhite;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (!self.isWhite) {
        [[UIColor darkGrayColor] set];
    } else {
        [[UIColor lightGrayColor] set];
    }
    
    CGFloat half = rect.size.width/2.0;
    CGFloat rai = MAX(MIN(20, half-10),10);
    
    CGContextAddArc(ctx, half, half, rai, 0, M_PI*2, 0);
    CGContextFillPath(ctx);
}

@end
