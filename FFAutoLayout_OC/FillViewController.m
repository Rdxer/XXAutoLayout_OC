//
//  FillViewController.m
//  FFAutoLayout_OC
//
//  Created by LXF on 15/10/18.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "FillViewController.h"
#import "UIView+AdjustFrame.h"
#import "UIView+AutoLayout.h"


#define screenBounds [UIScreen mainScreen].bounds
#define margin 10

@interface FillViewController ()

@property (nonatomic, assign) CGFloat currY;
@property (nonatomic, strong) UIScrollView *scrollV;

@end

@implementation FillViewController

-(void)loadView{
    self.scrollV = [[UIScrollView alloc]initWithFrame:screenBounds];
    self.view = self.scrollV;
    self.scrollV.contentSize = CGSizeMake(screenBounds.size.width, screenBounds.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    #pragma mark - 固定高度填充
    
    UIView *v = [self addContentView];
    UIButton *fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"顶部填充 高度 100" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeTop referView:v constant:100 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIButton *fillLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:fillLeftBtn];
    [fillLeftBtn setTitle:@"正方形" forState:UIControlStateNormal];
    fillLeftBtn.backgroundColor = [UIColor redColor];
    [fillLeftBtn xx_FillWithType:xx_FillTypeLeft referView:fillV insets:UIEdgeInsetsMake(10, 10, 10, 0)];
    
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"底部填充 高度 100" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeBotton referView:v constant:100 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    v = [self addContentView];
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"左部填充 高度 100" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeLeft referView:v constant:100 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"右部填充 高度 100" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeRight referView:v constant:100 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    
    #pragma mark - 参照填充
    
    v = [self addContentView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    [v addSubview:btn];
    [btn xx_AlignInnerWithType:xx_AlignTypeCenterCenter referView:v size:CGSizeMake(100, 100) offset:CGPointZero];
    
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"顶部填充 高度 填充到中间的 view 为止" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeTop referView:v referView:btn insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"底部填充 高度 填充到中间的 view 为止" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeBotton referView:v referView:btn insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    v = [self addContentView];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    [v addSubview:btn];
    [btn xx_AlignInnerWithType:xx_AlignTypeCenterCenter referView:v size:CGSizeMake(100, 100) offset:CGPointZero];
    
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"左" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeLeft referView:v referView:btn insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    fillV = [UIButton buttonWithType:UIButtonTypeCustom];
    fillV.backgroundColor = [UIColor orangeColor];
    [fillV setTitle:@"右" forState:UIControlStateNormal];
    [v addSubview:fillV];
    [fillV xx_FillWithType:xx_FillTypeRight referView:v referView:btn insets:UIEdgeInsetsMake(10, 10, 10, 10)];
}


- (UIView *)addContentView{
    UIView *v = [[UIView alloc]initWithFrame:screenBounds];
    v.backgroundColor = [UIColor lightGrayColor];
    v.y = self.currY;
    v.height *= 0.5;
    self.currY += (margin + v.height);
    self.scrollV.contentSize = CGSizeMake(screenBounds.size.width, screenBounds.size.height + self.currY);
    [self.scrollV addSubview:v];
    
    return v;
}
@end
