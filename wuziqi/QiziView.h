//
//  QiziView.h
//  wuziqi
//
//  Created by lixy on 16/1/19.
//  Copyright © 2016年 lixy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiPanView.h"

@interface QiziView : UIView

@property (nonatomic, assign, readonly) BOOL isWhite;

- (void)addOneQiziWithPoint:(CGPoint)point;
- (BOOL)hasQiziAtPoint:(CGPoint)point;

@end
