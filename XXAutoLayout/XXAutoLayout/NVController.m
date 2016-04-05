//
//  NVController.m

//
//  Created by LXF on 15/10/10.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "NVController.h"

@interface NVController ()<UIGestureRecognizerDelegate>

@end

@implementation NVController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop

    // 设置手势代理，拦截手势触发
    pan.delegate = self;

    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];

    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}


@end
