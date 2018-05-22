//
//  MainViewController.m
//  wuziqi
//
//  Created by lixy on 16/1/19.
//  Copyright © 2016年 lixy. All rights reserved.
//

#import "MainViewController.h"
#import "NextStepColorView.h"
#import "QiziView.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet NextStepColorView *nextStep;
@property (weak, nonatomic) IBOutlet QiziView *qiziView;
@property (weak, nonatomic) IBOutlet QiPanView *qipanView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.qiziView addObserver:self forKeyPath:@"isWhite" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isWhite"]) {
        
        BOOL isWhite = ((QiziView*)object).isWhite;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nextStep.isWhite = isWhite;
        });
    }
}

- (void)dealloc
{
    [self.qiziView removeObserver:self forKeyPath:@"isWhite"];
}

- (IBAction)xiaqi:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.qiziView];
    [self.qiziView addOneQiziWithPoint:point];
}

- (IBAction)suofang:(UIPinchGestureRecognizer *)sender
{
    self.qipanView.transform = CGAffineTransformScale(self.qipanView.transform, sender.scale, sender.scale);
    sender.scale = 1;
}

- (IBAction)move:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:self.qipanView];
    self.qipanView.transform = CGAffineTransformTranslate(self.qipanView.transform, point.x, point.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.qipanView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
