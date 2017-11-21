//
//  JKGestureImageView.m
//  JKGestureImageView
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 JackLiao. All rights reserved.
//

#import "JKGestureImageView.h"

@implementation JKGestureImageView{
    CGRect originFrame;
    CGRect maxFrame;
    CGRect minFrame;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        originFrame = frame;
        minFrame = CGRectMake(CGRectGetMinX(frame)+CGRectGetWidth(frame)/4, CGRectGetMinY(frame)+CGRectGetHeight(frame)/4, CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        maxFrame = CGRectMake(CGRectGetMinX(frame)-CGRectGetWidth(frame), CGRectGetMinY(frame)-CGRectGetHeight(frame), CGRectGetWidth(frame)*3, CGRectGetHeight(frame)*3);
        [self addGestures];
    }
    return self;
}


-(void)addGestures{
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    [self addGestureRotation];
    [self addGesturePinch];
    [self addGesturePan];
//    [self addGestureDoubleTap];
}

-(void)addGestureDoubleTap{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    tapGestureRecognizer.numberOfTouchesRequired = 2;
    [self addGestureRecognizer:tapGestureRecognizer];
}

-(void)tapView:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    if (CGRectGetWidth(self.frame) >= CGRectGetWidth(maxFrame)){
        self.frame = originFrame;
    }else{
        CGRect preFrame;

        CGPoint lastCenter = self.center;
        CGSize preSize = CGSizeMake(CGRectGetWidth(self.frame)*1.2, CGRectGetHeight(self.frame)*1.2);
        if (preSize.width >= CGRectGetWidth(maxFrame)) {
            preFrame.size = maxFrame.size;
        }else{
            preFrame.size = preSize;
        }
        self.frame = preFrame;
        self.center = lastCenter;
    }
    
}

-(void)addGestureRotation{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [self addGestureRecognizer:rotationGestureRecognizer];
}
// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

-(void)addGesturePinch{
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self addGestureRecognizer:pinchGestureRecognizer];
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (CGRectGetWidth(self.frame) <= CGRectGetWidth(minFrame)) {
            self.frame = minFrame;
        }else if (CGRectGetWidth(self.frame) >= CGRectGetWidth(maxFrame)){
            self.frame = maxFrame;
        }
        pinchGestureRecognizer.scale = 1;
    }
}

-(void)addGesturePan{
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}


@end
