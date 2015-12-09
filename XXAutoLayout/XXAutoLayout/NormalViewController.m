//
//  NormalViewController.m
//  FFAutoLayout_OC
//
//  Created by LXF on 15/10/18.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "NormalViewController.h"
#import "UIView+AutoLayout.h"


#define margin 4
#define w 55
#define h w
#define contentW 200
#define contentH contentW


@interface NormalViewController ()


@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:contentView];
    
    [contentView xx_AlignInnerWithType:xx_AlignTypeCenterCenter referView:self.view size:CGSizeMake(contentW, contentH) offset:CGPointZero];
    
    
    UIButton *btn;
    
    #pragma mark - AlignInner
    
    btn = [self addButtonWithTitle:@"上中"];
    
    [btn xx_AlignInnerWithType:xx_AlignTypeTopCenter referView:contentView size:CGSizeNull() offset:CGPointMake(0, margin)];
    
    btn = [self addButtonWithTitle:@"上左"];
    [btn xx_AlignInnerWithType:xx_AlignTypeTopLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, margin)];
    
    btn = [self addButtonWithTitle:@"上右"];
    [btn xx_AlignInnerWithType:xx_AlignTypeTopRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, margin)];
    
    btn = [self addButtonWithTitle:@"中中"];
    [btn xx_AlignInnerWithType:xx_AlignTypeCenterCenter referView:contentView size:CGSizeMake(w, h) offset:CGPointZero];
    
    btn = [self addButtonWithTitle:@"中左"];
    [btn xx_AlignInnerWithType:xx_AlignTypeCenterLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, 0)];
    
    btn = [self addButtonWithTitle:@"中右"];
    [btn xx_AlignInnerWithType:xx_AlignTypeCenterRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, 0)];
    
    btn = [self addButtonWithTitle:@"下中"];
    [btn xx_AlignInnerWithType:xx_AlignTypeBottomCenter referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(0, -margin)];
    
    btn = [self addButtonWithTitle:@"下左"];
    [btn xx_AlignInnerWithType:xx_AlignTypeBottomLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, -margin)];
    
    btn = [self addButtonWithTitle:@"下右"];
    [btn xx_AlignInnerWithType:xx_AlignTypeBottomRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, -margin)];
    
    
    #pragma mark - AlignVertical
    
    btn = [self addButtonWithTitle:@"上中"];
    [btn xx_AlignVerticalWithType:xx_AlignTypeTopCenter referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(0, -margin)];
    
    btn = [self addButtonWithTitle:@"上左"];
    [btn xx_AlignVerticalWithType:xx_AlignTypeTopLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, -margin)];
    
    btn = [self addButtonWithTitle:@"上右"];
    [btn xx_AlignVerticalWithType:xx_AlignTypeTopRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, -margin)];
    
    
    btn = [self addButtonWithTitle:@"下中"];
    [btn xx_AlignVerticalWithType:xx_AlignTypeBottomCenter referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(0, margin)];
    
    btn = [self addButtonWithTitle:@"下左"];
    [btn xx_AlignVerticalWithType:xx_AlignTypeBottomLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, margin)];
    
    btn = [self addButtonWithTitle:@"下右"];
    [btn xx_AlignVerticalWithType:xx_AlignTypeBottomRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, margin)];
    
    
    #pragma mark - AlignHorizontal
    
    btn = [self addButtonWithTitle:@"左上"];
    [btn xx_AlignHorizontalWithType:xx_AlignTypeTopLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, 0)];
    btn = [self addButtonWithTitle:@"左中"];
    [btn xx_AlignHorizontalWithType:xx_AlignTypeCenterLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, 0)];
    btn = [self addButtonWithTitle:@"左下"];
    [btn xx_AlignHorizontalWithType:xx_AlignTypeBottomLeft referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(-margin, 0)];
    
    btn = [self addButtonWithTitle:@"右上"];
    [btn xx_AlignHorizontalWithType:xx_AlignTypeTopRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, 0)];
    btn = [self addButtonWithTitle:@"右中"];
    [btn xx_AlignHorizontalWithType:xx_AlignTypeCenterRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, 0)];
    btn = [self addButtonWithTitle:@"右下"];
    [btn xx_AlignHorizontalWithType:xx_AlignTypeBottomRight referView:contentView size:CGSizeMake(w, h) offset:CGPointMake(margin, 0)];
    
    
    
}

- (UIButton *)addButtonWithTitle:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:title forState: UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    return btn;
}


@end
