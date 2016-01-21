//
//  QiPan.m
//  wuziqi
//
//  Created by lixy on 16/1/19.
//  Copyright © 2016年 lixy. All rights reserved.
//

#import "QiPanView.h"

@implementation QiPanView

- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat perWidth = width/(LineNum*1.0);
    CGFloat halfPerWidth = perWidth/2.;
    UIBezierPath *bp = [UIBezierPath bezierPath];
    [bp setLineWidth:1];
    [[UIColor lightGrayColor] set];
    
    //绘制棋盘
    for (int i=0; i<LineNum; i++) {
        [bp moveToPoint:CGPointMake(halfPerWidth, i*perWidth+halfPerWidth)];
        [bp addLineToPoint:CGPointMake(width-halfPerWidth, i*perWidth+halfPerWidth)];
        
        [bp moveToPoint:CGPointMake(i*perWidth+halfPerWidth, halfPerWidth)];
        [bp addLineToPoint:CGPointMake(i*perWidth+halfPerWidth, width-halfPerWidth)];
    }
    
    [bp stroke];
}

@end
