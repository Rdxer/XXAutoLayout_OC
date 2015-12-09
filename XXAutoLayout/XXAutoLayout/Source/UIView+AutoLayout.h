//
//  UIView+AutoLayout.h
//
//  Created by LXF on 15/9/29.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import <UIKit/UIKit.h>

/// CGSizeNull != CGSizeZero
/// 不需要 对 size 设置约束时,使用此 size
#define CGSizeNullV CGSizeMake(CGFLOAT_MIN,CGFLOAT_MIN)

/// 返回 CGSizeNull (为了兼容 Swift)
CGSize CGSizeNull();

/// 对齐类型枚举，设置控件相对于父视图的位置
typedef NS_ENUM(NSInteger, xx_AlignType){
    /// 左上
    xx_AlignTypeTopLeft,
    /// 右上
    xx_AlignTypeTopRight,
    /// 上中
    xx_AlignTypeTopCenter,
    /// 左下
    xx_AlignTypeBottomLeft,
    /// 右下
    xx_AlignTypeBottomRight,
    /// 下中
    xx_AlignTypeBottomCenter,
    /// 左中
    xx_AlignTypeCenterLeft,
    /// 右中
    xx_AlignTypeCenterRight,
    /// 居中
    xx_AlignTypeCenterCenter
};

/// 填充类型枚举
typedef NS_ENUM(NSInteger, xx_FillType){
    /// 顶部填充
    xx_FillTypeTop = xx_AlignTypeTopLeft,
    /// 左边填充
    xx_FillTypeLeft = xx_AlignTypeBottomLeft,
    /// 下填充
    xx_FillTypeBotton = xx_AlignTypeBottomRight,
    /// 右填充
    xx_FillTypeRight = xx_AlignTypeTopRight
};

@interface UIView (AutoLayout)

/// 部分填充 (正方形填充)
///
/// @param type      填充类型
/// @param referView 填充的参考视图
/// @param insets    边距
///
/// @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView insets: (UIEdgeInsets )insets;

/// 部分填充
///
/// @param type       填充类型
/// @param referView  填充的参考视图
/// @param referView2 填充范围的参考视图 (如果为 nil,则不会添加)
/// @param constant   填充的大小 (如果值为 CGFLOAT_MIN 不添加约束)
/// @param insets     边距
///
/// @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView referView:(nullable UIView *)referView2 constant:(CGFloat)constant insets: (UIEdgeInsets )insets;

/// 部分填充(固定大小)
///
/// @param type      填充的方向
/// @param referView 参考视图
/// @param constant  填充方向的常量约束 (值为 CGFLOAT_MIN 不添加约束)
/// @param insets    边距
///
/// @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView constant:(CGFloat)constant insets: (UIEdgeInsets)insets;

/// 部分填充(填充视图的一个方向,参照两个 View)
///
/// @param type         填充的方向
/// @param referView    参考视图
/// @param referView2   填充范围的参考视图 (为 nil 不添加约束)
/// @param insets       边距
///
/// @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView referView:(nonnull UIView *)referView2 insets: (UIEdgeInsets )insets;

/// 全部填充
///
/// @param referView 参考视图
/// @param insets    间距
///
/// @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithReferView:(nonnull UIView *)referView insets: (UIEdgeInsets )insets;

///  参照参考视图内部对齐
///
///  @param type:      对齐方式
///  @param referView: 参考视图
///  @param size:      视图大小，如果是 CGSizeNull(CGFLOAT_MIN,CGFLOAT_MIN) 则不设置大小
///  @param offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_AlignInnerWithType:(xx_AlignType)type referView:(nonnull UIView *)referView size:(CGSize)size offset:(CGPoint)offset;

///  参照参考视图垂直对齐
///
///  @param type:      对齐方式
///  @param referView: 参考视图
///  @param size:      视图大小，如果是 CGSizeNull(CGFLOAT_MIN,CGFLOAT_MIN) 则不设置大小
///  @param offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_AlignVerticalWithType:(xx_AlignType)type referView:(nonnull UIView *)referView size:(CGSize)size offset:(CGPoint)offset;

///  参照参考视图水平对齐
///
///  @param type:      对齐方式
///  @param referView: 参考视图
///  @param size:      视图大小，如果是 CGSizeNull(CGFLOAT_MIN,CGFLOAT_MIN) 则不设置大小
///  @param offset:    偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_AlignHorizontalWithType:(xx_AlignType)type referView:(nonnull UIView *)referView size:(CGSize)size offset:(CGPoint)offset;

///  在当前视图内部水平平铺控件
///
///  @param views:  子视图数组
///  @param insets: 间距
///
///  @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_HorizontalTileWithSubviews:(nonnull NSArray<UIView *> *)subViews insets:(UIEdgeInsets)insets;

///  在当前视图内部垂直平铺控件
///
///  @param views:  子视图数组
///  @param insets: 间距
///
///  @return 约束数组
- (nonnull NSArray<NSLayoutConstraint *> *)xx_VerticalTileWithSubviews:(nonnull NSArray<UIView *> *)subViews insets:(UIEdgeInsets)insets;

///  从约束数组中查找指定 attribute 的约束
///
///  @param constraintsList: 约束数组
///  @param attribute:       约束属性
///
///  @return attribute 对应的约束
- (nullable NSLayoutConstraint *)xx_ConstraintWithConstraintsList:(nonnull NSArray<  NSLayoutConstraint *> *)constraintsList attribute:(NSLayoutAttribute)attribute;

@end

@interface xx_LayoutAttributes : NSObject


@end



