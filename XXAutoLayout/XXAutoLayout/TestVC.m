//
//  TestVC.m
//  FFAutoLayout_OC
//
//  Created by LXF on 15/11/5.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "TestVC.h"

#import "UIView+AutoLayout.h"

@interface TestVC ()

@property (nonatomic, weak) UIView *view2;

@property (nonatomic, strong) NSLayoutConstraint *constraintH;

@end

@implementation TestVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self view2];
    
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor blueColor];
    [self.view addSubview:v];
    [v xx_FillWithType:xx_FillTypeLeft referView:self.view2 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIView *v2 = [[UIView alloc]init];
    v2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:v2];
    [v2 xx_FillWithType:xx_FillTypeRight referView:self.view2 referView:v insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [self addGestureRecognizer];
    
    
}


-(UIView *)view2{
    if (_view2 == nil) {
        UIView *view2 = [[UIView alloc] init];
        [self.view addSubview:view2];
        view2.backgroundColor = [UIColor orangeColor];
        NSArray *array = [view2 xx_FillWithType:xx_FillTypeBotton referView:self.view constant:100 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        self.constraintH = [view2 xx_ConstraintWithConstraintsList:array attribute:NSLayoutAttributeHeight];
        
        _view2 = view2;
    }
    return _view2;
}

- (void)addGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view2 addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    // 获取相对的位移
    CGPoint point = [pan translationInView:self.view2];
    
    self.constraintH.constant = self.constraintH.constant + (-point.y);
    
    //设置
//    self.view2.transform = CGAffineTransformTranslate(self.view2.transform, point.x, point.y);
//    //复位
   [pan setTranslation:CGPointZero inView:self.view2];
}
@end
