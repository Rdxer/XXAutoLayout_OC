//
//  UIView+AutoLayout.m
//
//  Created by LXF on 15/9/29.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "UIView+AutoLayout.h"

/// 返回 CGSizeNull
CGSize CGSizeNull(){
    return CGSizeNullV;
}

@interface xx_LayoutAttributes ()

@property (nonatomic, assign) NSLayoutAttribute horizontal;
@property (nonatomic, assign) NSLayoutAttribute referHorizontal;
@property (nonatomic, assign) NSLayoutAttribute vertical;
@property (nonatomic, assign) NSLayoutAttribute referVertical;

@property (nonatomic, assign) NSLayoutAttribute fill;
@property (nonatomic, assign) NSLayoutAttribute referFill;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, assign) CGFloat constant;

@property (nonatomic, assign) CGFloat otherConstant;
@property (nonatomic, assign) NSLayoutAttribute otherFillAttribute;
@property (nonatomic, assign) NSLayoutAttribute referOtherFillAttribute;

+(instancetype)layoutAttributesWithFillType:(xx_FillType) type insets: (UIEdgeInsets)insets;
+(instancetype)layoutAttributesWithType:(xx_AlignType) type isInner:(BOOL) isInner isVertical:(BOOL) isVertical;

- (instancetype)initWithHorizontal:(NSLayoutAttribute)horizontal referHorizontal:(NSLayoutAttribute)referHorizontal vertical:(NSLayoutAttribute)vertical referVertical:(NSLayoutAttribute)referVertical;

- (instancetype)horizontalsWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to;
- (instancetype)verticalsWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to;
- (instancetype)fillWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to;
- (instancetype)fillOtherWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to;

@end


@implementation UIView (AutoLayout)
/// 填充视图的一个方向(宽高相等)
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView insets: (UIEdgeInsets )insets{
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    [cons addObjectsFromArray:[self xx_FillWithType:type referView:referView referView:nil constant:CGFLOAT_MIN insets:insets]];
    
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.superview addConstraint:con];
    [cons addObject:con];
    return cons;
}
/// 填充视图的一个方向(固定大小)
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView constant:(CGFloat)constant insets: (UIEdgeInsets )insets{
    return [self xx_FillWithType:type referView:referView referView:nil constant:constant insets:insets];
}
/// 填充视图的一个方向(参照两个 View)
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView referView:(nonnull UIView *)referView2 insets: (UIEdgeInsets )insets{
    return [self xx_FillWithType:type referView:referView referView:referView2 constant:CGFLOAT_MIN insets:insets];
}

/// 填充
- (nonnull NSArray<NSLayoutConstraint *> *)xx_FillWithType:(xx_FillType)type referView:(nonnull UIView *)referView referView:(nullable UIView *)referView2 constant:(CGFloat)constant insets: (UIEdgeInsets )insets{
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    xx_LayoutAttributes *attributes = [xx_LayoutAttributes layoutAttributesWithFillType:type insets: (UIEdgeInsets)insets];
    
    CGSize size = (type == xx_FillTypeRight || type == xx_FillTypeLeft) ? CGSizeMake(constant, CGFLOAT_MIN):CGSizeMake(CGFLOAT_MIN, constant);
    
    [cons addObjectsFromArray:[self xx_AlignLayoutWithReferView:referView attributes:attributes size:size offset:attributes.offset]];
    
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:self attribute:attributes.fill relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referFill multiplier:1.0 constant:attributes.constant];
    [self.superview addConstraint:con];
    [cons addObject:con];
    
    if (referView2) {
        con = [NSLayoutConstraint constraintWithItem:self attribute:attributes.otherFillAttribute relatedBy:NSLayoutRelationEqual toItem:referView2 attribute:attributes.referOtherFillAttribute multiplier:1.0 constant:attributes.otherConstant];
        [self.superview addConstraint:con];
        [cons addObject:con];
    }
    
    return cons;
}

/// 填充子视图
- (NSArray<NSLayoutConstraint *> *)xx_FillWithReferView:(UIView *)referView insets: (UIEdgeInsets )insets{
    
    NSAssert(self.superview != nil, @"父视图不能为空 请将该 view 添加到视图中");
    
    self.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{@"insets_left":@(insets.left),@"insets_right":@(insets.right),@"insets_top":@(insets.top),@"insets_bottom":@(insets.bottom)};
    NSDictionary *views = @{@"subView" : self};
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    NSArray<NSLayoutConstraint *> *cs = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(insets_left)-[subView]-\(insets_right)-|" options:NSLayoutFormatAlignAllBaseline metrics:metrics views:views];
    
    [cons addObjectsFromArray:cs];
    
    cs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(insets_top)-[subView]-\(insets_bottom)-|" options:NSLayoutFormatAlignAllBaseline metrics:metrics views:views];

    [cons addObjectsFromArray:cs];
    
    [self.superview addConstraints:cons];
    
    return cons;
}

///  参照参考视图内部对齐
- (NSArray<NSLayoutConstraint *> *)xx_AlignInnerWithType:(xx_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset{
    xx_LayoutAttributes *attributes = [xx_LayoutAttributes layoutAttributesWithType:type isInner:YES isVertical:YES];
    return [self xx_AlignLayoutWithReferView:referView attributes:attributes size:size offset:offset];
}

///  参照参考视图垂直对齐
- (NSArray<NSLayoutConstraint *> *)xx_AlignVerticalWithType:(xx_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset{
    xx_LayoutAttributes *attributes = [xx_LayoutAttributes layoutAttributesWithType:type isInner:NO isVertical:YES];
    return [self xx_AlignLayoutWithReferView:referView attributes:attributes size:size offset:offset];
}

///  参照参考视图水平对齐
- (NSArray<NSLayoutConstraint *> *)xx_AlignHorizontalWithType:(xx_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset{
    xx_LayoutAttributes *attributes = [xx_LayoutAttributes layoutAttributesWithType:type isInner:NO isVertical:NO];
    return [self xx_AlignLayoutWithReferView:referView attributes:attributes size:size offset:offset];
}

///  在当前视图内部水平平铺控件
- (NSArray<NSLayoutConstraint *> *)xx_HorizontalTileWithSubviews:(NSArray<UIView *> *)subViews insets:(UIEdgeInsets)insets{
    
    NSAssert([subViews count] > 0, @"Subviews should not be empty");
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    UIView *firstView = subViews.firstObject;
    
    [firstView xx_AlignInnerWithType:xx_AlignTypeTopLeft referView:self size:CGSizeNull() offset:CGPointMake(insets.left, insets.top)];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-insets.bottom]];
    
    int count = (int)subViews.count;
    UIView *preView = firstView;
    for (int i = 1; i < count; ++i) {
        UIView * v = subViews[i];
        [cons addObjectsFromArray:[v xx_sizeConstraintsWithReferView:firstView]];
        [v xx_AlignHorizontalWithType:xx_AlignTypeTopRight referView:preView size:CGSizeNull() offset:CGPointMake(insets.right, 0)];
        preView = v;
    }
    
    UIView *lastView = subViews.lastObject;
    [cons addObject:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets.right]];
    
    [self addConstraints:cons];
    
    return cons;
}

///  在当前视图内部垂直平铺控件
- (NSArray<NSLayoutConstraint *> *)xx_VerticalTileWithSubviews:(NSArray<UIView *> *)subViews insets:(UIEdgeInsets)insets{
    
    NSAssert([subViews count] > 0, @"Subviews should not be empty");
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    UIView *firstView = subViews[0];
    
    [firstView xx_AlignInnerWithType:xx_AlignTypeTopLeft referView:self size:CGSizeNull() offset:CGPointMake(insets.left, insets.top)];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets.bottom]];
    
    int count = (int)subViews.count;
    
    UIView *preView = firstView;
    
    for (int i = 1; i < count; ++i) {
        UIView * v = subViews[i];
        [cons addObjectsFromArray:[v xx_sizeConstraintsWithReferView:firstView]];
        [v xx_AlignVerticalWithType:xx_AlignTypeBottomLeft referView:preView size:CGSizeNull() offset:CGPointMake(0, insets.bottom)];
        preView = v;
    }
    
    UIView *lastView = subViews.lastObject;
    [cons addObject:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-insets.bottom]];
    
    [self.subviews containsObject:subViews.firstObject] ? [self addConstraints:cons] : [self.superview addConstraints:cons];
    
    return nil;
}

- (nullable NSLayoutConstraint *)xx_ConstraintWithConstraintsList:(NSArray<NSLayoutConstraint *> *)constraintsList attribute:(NSLayoutAttribute)attribute{
    
    for (NSLayoutConstraint *cont in constraintsList) {
        if (cont.firstItem == self && cont.firstAttribute == attribute) {
            return cont;
        }
    }
    
    return nil;
}

// MARK: 私有函数

///  参照参考视图对齐布局
///
///  @param referView:  参考视图
///  @param attributes: 参照属性
///  @param size:       视图大小，如果是 CGSizeNull(={-1,-1}) 则不设置大小
///  @param offset:     偏移量，默认是 CGPoint(x: 0, y: 0)
///
///  @return 约束数组
- (NSArray<NSLayoutConstraint *> *)xx_AlignLayoutWithReferView:(UIView *)referView attributes:(xx_LayoutAttributes *)attributes size:(CGSize)size offset:(CGPoint)offset {
    
    NSAssert(self.superview != nil, @"父视图不能为空 请将该 view 添加到视图中");
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    [cons addObjectsFromArray:[self xx_positionConstraintsWithReferView:referView attributes:attributes offset:offset]];
    
    [cons addObjectsFromArray:[self xx_sizeConstraintsWithSize:size]];
    
    [self.superview addConstraints:cons];
    
    return cons;
}

///  位置约束数组
///
///  @param referView:  参考视图
///  @param attributes: 参照属性
///  @param offset:     偏移量
///
///  @return 约束数组
-(NSArray<NSLayoutConstraint *> *)xx_positionConstraintsWithReferView:(UIView *)referView attributes:(xx_LayoutAttributes *)attributes offset:(CGPoint)offset{
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:attributes.horizontal relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referHorizontal multiplier:1.0 constant:offset.x]];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:attributes.vertical relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referVertical multiplier:1.0 constant:offset.y]];
    
    return  cons;
}

///  尺寸约束数组
///
///  @param size: 视图大小
///
///  @return 约束数组
-(NSArray<NSLayoutConstraint *> *)xx_sizeConstraintsWithSize:(CGSize)size{
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    if (size.width != CGFLOAT_MIN) {
        [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.width]];
    }
    if (size.height != CGFLOAT_MIN) {
        [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height]];
    }
    return cons;
}

///  尺寸约束数组
///
///  @param referView: 参考视图，与参考视图大小一致
///
///  @return 约束数组
-(NSArray<NSLayoutConstraint *> *)xx_sizeConstraintsWithReferView:(UIView *)referView{
    
    NSMutableArray<NSLayoutConstraint *> *cons = [[NSMutableArray alloc]init];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:referView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:referView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    return cons;
}

@end


@implementation xx_LayoutAttributes
+(instancetype)layoutAttributesWithFillType:(xx_FillType) type insets: (UIEdgeInsets)insets{
    xx_LayoutAttributes *attributes = [self layoutAttributesWithType:(xx_AlignType)type isInner:YES isVertical:YES];
    
    switch (type) {
        case xx_FillTypeTop:
            [attributes fillWithFrom:NSLayoutAttributeRight to:NSLayoutAttributeRight];
            attributes.offset = CGPointMake(insets.left, insets.top);
            attributes.constant = -insets.right;
            attributes.otherConstant = -insets.bottom;
            [attributes fillOtherWithFrom:NSLayoutAttributeBottom to:NSLayoutAttributeTop];
            break;
        case xx_FillTypeBotton:
            [attributes fillWithFrom:NSLayoutAttributeLeft to:NSLayoutAttributeLeft];
            attributes.offset = CGPointMake(-insets.right, -insets.bottom);
            attributes.constant = insets.left;
            attributes.otherConstant = insets.top;
            [attributes fillOtherWithFrom:NSLayoutAttributeTop to:NSLayoutAttributeBottom];
            break;
        case xx_FillTypeLeft:
            [attributes fillWithFrom:NSLayoutAttributeTop to:NSLayoutAttributeTop];
            attributes.offset = CGPointMake(insets.left, -insets.bottom);
            attributes.constant = insets.top;
            attributes.otherConstant = -insets.right;
            [attributes fillOtherWithFrom:NSLayoutAttributeRight to:NSLayoutAttributeLeft];
            break;
        case xx_FillTypeRight:
            [attributes fillWithFrom:NSLayoutAttributeBottom to:NSLayoutAttributeBottom];
            attributes.offset = CGPointMake(-insets.right, insets.top);
            attributes.constant = -insets.bottom;
            attributes.otherConstant = insets.left;
            [attributes fillOtherWithFrom:NSLayoutAttributeLeft to:NSLayoutAttributeRight];
            break;
        default:NSAssert(NO, @"枚举值不正确");
            break;
    }
    return attributes;
}
+(instancetype)layoutAttributesWithType:(xx_AlignType) type isInner:(BOOL) isInner isVertical:(BOOL) isVertical {
    xx_LayoutAttributes *attributes = [[self alloc]init];
    
    switch(type) {
        case xx_AlignTypeTopLeft:
            [attributes horizontalsWithFrom:NSLayoutAttributeLeft to:NSLayoutAttributeLeft];
            [attributes verticalsWithFrom:NSLayoutAttributeTop to:NSLayoutAttributeTop];
            if(isInner){
                return attributes;
            } else if(isVertical){
                return [attributes verticalsWithFrom: NSLayoutAttributeBottom to: NSLayoutAttributeTop];
            } else {
                return [attributes horizontalsWithFrom:NSLayoutAttributeRight to: NSLayoutAttributeLeft];
            }
        case xx_AlignTypeTopRight:
            [attributes horizontalsWithFrom: NSLayoutAttributeRight to: NSLayoutAttributeRight];
            [attributes verticalsWithFrom: NSLayoutAttributeTop to: NSLayoutAttributeTop];
            
            if(isInner){
                return attributes;
            } else if(isVertical){
                return [attributes verticalsWithFrom: NSLayoutAttributeBottom to: NSLayoutAttributeTop];
            } else {
                return [attributes horizontalsWithFrom: NSLayoutAttributeLeft to: NSLayoutAttributeRight];
            }
        case xx_AlignTypeTopCenter:        // 仅内部 & 垂直参照需要
            [[attributes horizontalsWithFrom:NSLayoutAttributeCenterX  to:NSLayoutAttributeCenterX] verticalsWithFrom:NSLayoutAttributeTop  to:NSLayoutAttributeTop];
            return isInner ? attributes : [attributes verticalsWithFrom:NSLayoutAttributeBottom  to:NSLayoutAttributeTop];
        case xx_AlignTypeBottomLeft:
            [[attributes horizontalsWithFrom:NSLayoutAttributeLeft  to:NSLayoutAttributeLeft] verticalsWithFrom:NSLayoutAttributeBottom  to:NSLayoutAttributeBottom];
            
            if(isInner){
                return attributes;
            } else if(isVertical){
                return [attributes verticalsWithFrom:NSLayoutAttributeTop  to:NSLayoutAttributeBottom];
            } else {
                return [attributes horizontalsWithFrom:NSLayoutAttributeRight  to:NSLayoutAttributeLeft];
            }
        case xx_AlignTypeBottomRight:
            [[attributes horizontalsWithFrom:NSLayoutAttributeRight  to:NSLayoutAttributeRight] verticalsWithFrom:NSLayoutAttributeBottom  to:NSLayoutAttributeBottom];
            if(isInner){
                return attributes;
            } else if(isVertical){
                return [attributes verticalsWithFrom:NSLayoutAttributeTop  to:NSLayoutAttributeBottom];
            } else {
                return [attributes horizontalsWithFrom:NSLayoutAttributeLeft  to:NSLayoutAttributeRight];
            }
        case xx_AlignTypeBottomCenter:     // 仅内部 & 垂直参照需要
            [[attributes horizontalsWithFrom:NSLayoutAttributeCenterX  to:NSLayoutAttributeCenterX] verticalsWithFrom:NSLayoutAttributeBottom  to:NSLayoutAttributeBottom];
            return isInner ? attributes : [attributes verticalsWithFrom:NSLayoutAttributeTop  to:NSLayoutAttributeBottom];
        case xx_AlignTypeCenterLeft:       // 仅内部 & 水平参照需要
            [[attributes horizontalsWithFrom:NSLayoutAttributeLeft  to:NSLayoutAttributeLeft] verticalsWithFrom:NSLayoutAttributeCenterY  to:NSLayoutAttributeCenterY];
            return isInner ? attributes : [attributes horizontalsWithFrom:NSLayoutAttributeRight  to:NSLayoutAttributeLeft];
        case xx_AlignTypeCenterRight:      // 仅内部 & 水平参照需要
            [[attributes horizontalsWithFrom:NSLayoutAttributeRight  to:NSLayoutAttributeRight] verticalsWithFrom:NSLayoutAttributeCenterY  to:NSLayoutAttributeCenterY];
            return isInner ? attributes : [attributes horizontalsWithFrom:NSLayoutAttributeLeft  to:NSLayoutAttributeRight];
        case xx_AlignTypeCenterCenter:     // 仅内部参照需要
            return [[self alloc]initWithHorizontal:NSLayoutAttributeCenterX referHorizontal:NSLayoutAttributeCenterX vertical:NSLayoutAttributeCenterY referVertical:NSLayoutAttributeCenterY];
        default: NSAssert(NO, @"枚举值不正确");
            return nil;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.horizontal = NSLayoutAttributeLeft;
        self.referHorizontal = NSLayoutAttributeLeft;
        self.vertical = NSLayoutAttributeTop;
        self.referVertical = NSLayoutAttributeTop;
    }
    return self;
}

- (instancetype)initWithHorizontal:(NSLayoutAttribute)horizontal referHorizontal:(NSLayoutAttribute)referHorizontal vertical:(NSLayoutAttribute)vertical referVertical:(NSLayoutAttribute)referVertical
{
    self = [super init];
    if (self) {
        
        self.horizontal = horizontal;
        self.referHorizontal = referHorizontal;
        self.vertical = vertical;
        self.referVertical = referVertical;
    }
    return self;
}

- (instancetype)horizontalsWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to{
    self.horizontal = from;
    self.referHorizontal = to;
    return self;
}

- (instancetype)verticalsWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to{
    self.vertical = from;
    self.referVertical = to;
    return self;
}

-(instancetype)fillWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to{
    self.fill = from;
    self.referFill = to;
    return self;
}
- (instancetype)fillOtherWithFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to{
    self.otherFillAttribute = from;
    self.referOtherFillAttribute = to;
    return self;
}
@end

