//
//  QiziView.m
//  wuziqi
//
//  Created by lixy on 16/1/19.
//  Copyright © 2016年 lixy. All rights reserved.
//

#import "QiziView.h"

struct QiZi {
    int exit;//0 不存在 1 存在
    int type; //1 黑 2 白
    CGPoint point;
};
typedef struct QiZi QiZi;

@interface QiziView ()<UIAlertViewDelegate>
{
    QiZi array[15][15];
}

@property (nonatomic, strong) NSMutableArray *qiziArray;
@property (nonatomic, assign, readwrite) BOOL isWhite;

@end

@implementation QiziView

- (NSMutableArray *)qiziArray
{
    if (!_qiziArray) {
        _qiziArray = [NSMutableArray array];
    }
    return _qiziArray;
}

- (void)addOneQiziWithPoint:(CGPoint)point
{
    if (![self hasQiziAtPoint:point]) {
        
        CGFloat width = self.bounds.size.width;
        CGFloat perWidth = width/(LineNum*1.0);
        
        NSInteger row = (int)(point.y/perWidth);
        NSInteger col = (int)(point.x/perWidth);
        
        array[row][col].exit = 1;
        array[row][col].type = self.isWhite?2:1;
        array[row][col].point = CGPointMake(row, col);
        
        self.isWhite = !self.isWhite;
        
        [self setNeedsDisplay];
        
        //判断输赢
        if ([self isWinWithRow:row col:col]) {
            NSLog(@"type = %d 赢了", array[row][col].type);
            if (array[row][col].type == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"黑色赢了" message:nil delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"白色赢了" message:nil delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    for (int j=0; j<LineNum; j++) {
        for (int i=0; i<LineNum; i++) {
            array[i][j].exit=0;
            array[i][j].type=0;
        }
    }
    self.isWhite = NO;
    [self setNeedsDisplay];
}

- (int)numberOfLeftRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=col; i>=0; i--) {
        QiZi qizi2 = array[row][i];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (int)numberOfRightRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=col; i<=LineNum; i++) {
        QiZi qizi2 = array[row][i];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}


- (int)numberOfUpRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=row; i>=0; i--) {
        QiZi qizi2 = array[i][col];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (int)numberOfDownRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=row; i<=LineNum; i++) {
        QiZi qizi2 = array[i][col];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (int)numberOfLeftUpRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=col, j=row; i>=0&&j>=0; i--, j--) {
        QiZi qizi2 = array[j][i];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (int)numberOfRightDownRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=col, j=row; i<=LineNum&&j<=LineNum; i++,j++) {
        QiZi qizi2 = array[j][i];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (int)numberOfLeftDownRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=col, j=row; i>=0&&j<=LineNum; i--, j++) {
        QiZi qizi2 = array[j][i];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (int)numberOfRightUpRow:(NSInteger)row col:(NSInteger)col
{
    int num = 0;
    QiZi qizi = array[row][col];
    int type = qizi.type;
    
    for (NSInteger i=col, j=row; i<=LineNum&&j>=0; i++,j--) {
        QiZi qizi2 = array[j][i];
        if (type == qizi2.type) {
            num ++;
        } else {
            break;
        }
    }
    
    return num;
}

- (BOOL)isWinWithRow:(NSInteger)row col:(NSInteger)col
{
    //横着是否连着
    CGFloat left = [self numberOfLeftRow:row col:col];
    CGFloat right = [self numberOfRightRow:row col:col];;
    
    if (left+right>=6) {
        return YES;
    }
    
    //竖着是否连着
    left = [self numberOfUpRow:row col:col];
    right = [self numberOfDownRow:row col:col];
    
    if (left+right>=6) {
        return YES;
    }
    
    //斜着是否连着↘️
    left = [self numberOfLeftUpRow:row col:col];
    right = [self numberOfRightDownRow:row col:col];
    
    if (left+right>=6) {
        return YES;
    }
    
    //斜着是否连着 ↗️
    left = [self numberOfLeftDownRow:row col:col];
    right = [self numberOfRightUpRow:row col:col];
    
    if (left+right>=6) {
        return YES;
    }
    
    return NO;
}

//该点是否已经有棋子
- (BOOL)hasQiziAtPoint:(CGPoint)point
{
    CGFloat width = self.bounds.size.width;
    CGFloat perWidth = width/(LineNum*1.0);
    
    NSInteger row = (int)(point.y/perWidth);
    NSInteger col = (int)(point.x/perWidth);

    if (array[row][col].exit==1) {
        return YES;
    }
    
    return NO;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat perWidth = width/(LineNum*1.0);
    CGFloat halfPerWidth = perWidth/2.;
    
    //绘制棋子 棋子和棋盘分开是为了 减少重绘
    for (int j=0; j<LineNum; j++) {
        for (int i=0; i<LineNum; i++) {
            
            if (array[i][j].exit==1) {
            
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                
                if (array[i][j].type == 1) {
                    [[UIColor darkGrayColor] set];
                } else {
                    [[UIColor lightGrayColor] set];
                }
                
                CGContextAddArc(ctx, perWidth*j+halfPerWidth, perWidth*i+halfPerWidth, halfPerWidth, 0, M_PI*2, 0);
                CGContextFillPath(ctx);
            }
            
        }
    }
}

//点击检测
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self addOneQiziWithPoint:point];
}

@end
