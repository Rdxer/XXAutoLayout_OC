//
//  AppDelegate.h
//  FFAutoLayout_OC
//
//  Created by LXF on 15/10/18.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AdjustFrame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@property (nonatomic, assign,readonly) CGPoint selfCenter;

@end
