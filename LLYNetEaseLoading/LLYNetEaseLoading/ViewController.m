//
//  ViewController.m
//  LLYNetEaseLoading
//
//  Created by lly on 2017/4/22.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "ViewController.h"

#define kDistance 65

@interface ViewController ()
@property (nonatomic,strong) CAShapeLayer *layer1;
@property (nonatomic,strong) CAShapeLayer *layer11;
@property (nonatomic,strong) CAShapeLayer *layer2;
@property (nonatomic,strong) CAShapeLayer *layer3;
@property (nonatomic,strong) CAShapeLayer *layer4;

@property (nonatomic,strong) CAShapeLayer *anilayer1;
@property (nonatomic,strong) CAShapeLayer *anilayer2;
@property (nonatomic,strong) CAShapeLayer *anilayer3;
@property (nonatomic,strong) CAShapeLayer *anilayer4;


@property (nonatomic,strong) CAShapeLayer *animaShapeLayer;
@property (nonatomic,strong) CAShapeLayer *animationLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addDots];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePosition)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [link setPaused:NO];
}


- (void)updatePosition{

    CGPoint center = self.animationLayer.presentationLayer.position;
    CGRect frame = self.animationLayer.presentationLayer.frame;
//    NSLog(@"======%f     %f======",center.x,center.y);
//    NSLog(@"%f %f %f %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    
    CGFloat distanceLayer1 = [self getDistanceBetweenLayer:self.animationLayer layer2:self.layer1];
    CGFloat distanceLayer2 = [self getDistanceBetweenLayer:self.animationLayer layer2:self.layer2];
    CGFloat distanceLayer3 = [self getDistanceBetweenLayer:self.animationLayer layer2:self.layer3];
    CGFloat distanceLayer4 = [self getDistanceBetweenLayer:self.animationLayer layer2:self.layer4];
    
    CABasicAnimation *scaleAni = [self getScaleAnimation];
    
    if (distanceLayer1 < kDistance) {
        UIBezierPath *path = [self getCurrentPath:frame dynamicCenter:center staticFrame:self.layer1.frame staticCenter:self.layer1.position];
        self.anilayer1.path = path.CGPath;
        CGFloat scale = (kDistance-distanceLayer1)/kDistance * 0.2;
        self.layer1.affineTransform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
        
    }
    else{
        self.anilayer1.path = nil;
        self.layer1.affineTransform = CGAffineTransformMakeScale(1, 1);
    }
    
    if (distanceLayer2 < kDistance){
        UIBezierPath *path = [self getCurrentPath:frame dynamicCenter:center staticFrame:self.layer2.frame staticCenter:self.layer2.position];
        self.anilayer2.path = path.CGPath;
        
        CGFloat scale = (kDistance-distanceLayer2)/kDistance * 0.2;
        self.layer2.affineTransform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
        
    }
    else{
        self.anilayer2.path = nil;
        self.layer2.affineTransform = CGAffineTransformMakeScale(1, 1);

    }
    
    if (distanceLayer3 < kDistance){
        UIBezierPath *path = [self getCurrentPath:frame dynamicCenter:center staticFrame:self.layer3.frame staticCenter:self.layer3.position];
        self.anilayer3.path = path.CGPath;
        
        CGFloat scale = (kDistance-distanceLayer3)/kDistance * 0.2;
        self.layer3.affineTransform = CGAffineTransformMakeScale(1 + scale, 1 + scale);

    }
    else{
        self.anilayer3.path = nil;
        self.layer3.affineTransform = CGAffineTransformMakeScale(1, 1);

    }
    
    if (distanceLayer4 < kDistance){
        UIBezierPath *path = [self getCurrentPath:frame dynamicCenter:center staticFrame:self.layer4.frame staticCenter:self.layer4.position];
        self.anilayer4.path = path.CGPath;
        
        CGFloat scale = (kDistance-distanceLayer4)/kDistance * 0.2;
        self.layer4.affineTransform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
        
    }
    else{
        self.anilayer4.path = nil;
        self.layer4.affineTransform = CGAffineTransformMakeScale(1, 1);
    }


}

- (CGFloat)getDistanceBetweenLayer:(CAShapeLayer *)layer1 layer2:(CAShapeLayer *)layer2{

    CGPoint layerCenter1 = layer1.presentationLayer.position;
    CGPoint layerCenter2 = layer2.position;
    
    return sqrt((layerCenter1.x - layerCenter2.x) * (layerCenter1.x - layerCenter2.x) + (layerCenter1.y - layerCenter2.y) *  (layerCenter1.y - layerCenter2.y));
}


- (UIBezierPath *)getCurrentPath:(CGRect)dynamicFrame dynamicCenter:(CGPoint)dynamicCneter staticFrame:(CGRect)staticFrame staticCenter:(CGPoint)staticCenter{

//    CGFloat gynamicRadius = dynamicFrame.size.width/2;
//    CGFloat staticRadius = staticFrame.size.width/2;
    
//    CGFloat centerDistance = sqrt((dynamicCneter.x - staticCenter.x) * (dynamicCneter.x - staticCenter.x) + (dynamicCneter.y - staticCenter.y) *  (dynamicCneter.y - staticCenter.y));
    
//    CGFloat sinDegree = (staticCenter.x - dynamicCneter.x) / centerDistance;
//    CGFloat cosDegree = (staticCenter.y - dynamicCneter.y) / centerDistance;
    
    CGPoint centerPoint = CGPointMake((dynamicCneter.x + staticCenter.x)/2, (dynamicCneter.y + staticCenter.y)/2);
    
    CGPoint pt1 = CGPointMake(dynamicCneter.x, dynamicFrame.origin.y);
    CGPoint pt2 = CGPointMake(dynamicCneter.x, dynamicFrame.origin.y + dynamicFrame.size.height);
    
    CGPoint pt3 = CGPointMake(staticCenter.x, staticFrame.origin.y);
    CGPoint pt4 = CGPointMake(staticCenter.x, staticFrame.origin.y + staticFrame.size.height);
    
//    CGPoint conPt1 = CGPointMake(pt1.x + (centerDistance / 2) * sinDegree, pt1.y + (centerDistance / 2) * cosDegree);
//    CGPoint conPt2 = CGPointMake(pt4.x + (centerDistance / 2) * sinDegree, pt4.y + (centerDistance / 2) * cosDegree);

    CGPoint conPt1 = CGPointMake(centerPoint.x, centerPoint.y - 10);
    CGPoint conPt2 = CGPointMake(centerPoint.x, centerPoint.y + 10);

    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pt1];
    [path addQuadCurveToPoint:pt3 controlPoint:conPt1];
    [path addLineToPoint:pt4];
    [path addQuadCurveToPoint:pt2 controlPoint:conPt2];
    [path addLineToPoint:pt1];
    
    
    return path;

}


- (CAShapeLayer *)animaShapeLayer{
    if (!_animaShapeLayer) {
        _animaShapeLayer = [CAShapeLayer layer];
        _animaShapeLayer.fillColor = [UIColor redColor].CGColor;
        _animaShapeLayer.anchorPoint = CGPointMake(0, 0);
        _animaShapeLayer.position = CGPointMake(0, 0);
    }
    return _animaShapeLayer;
}


- (CAShapeLayer *)anilayer1{
    if (!_anilayer1) {
        _anilayer1 = [CAShapeLayer layer];
        _anilayer1.fillColor = [UIColor redColor].CGColor;
        _anilayer1.frame = CGRectMake(0, 0, 60, 60);
    }
    return _anilayer1;
}

- (CAShapeLayer *)anilayer2{
    if (!_anilayer2) {
        _anilayer2 = [CAShapeLayer layer];
        _anilayer2.fillColor = [UIColor redColor].CGColor;
        _anilayer2.frame = CGRectMake(0, 0, 60, 60);
    }
    return _anilayer2;
}

- (CAShapeLayer *)anilayer3{
    if (!_anilayer3) {
        _anilayer3 = [CAShapeLayer layer];
        _anilayer3.fillColor = [UIColor redColor].CGColor;
        _anilayer3.frame = CGRectMake(0, 0, 60, 60);
    }
    return _anilayer3;
}

- (CAShapeLayer *)anilayer4{
    if (!_anilayer4) {
        _anilayer4 = [CAShapeLayer layer];
        _anilayer4.fillColor = [UIColor redColor].CGColor;
        _anilayer4.frame = CGRectMake(0, 0, 60, 60);

    }
    return _anilayer4;
}



- (void)addDots{
    
    self.animaShapeLayer.frame = CGRectMake(0, 0, 60, 60);
    [self.view.layer addSublayer:self.animaShapeLayer];

    self.layer1 = [CAShapeLayer layer];
    self.layer1.frame = CGRectMake(0, 0, 60, 60);
    self.layer1.cornerRadius = 30;
    self.layer1.backgroundColor = [UIColor redColor].CGColor;
    self.layer1.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer1];
    self.layer1.position = CGPointMake(60, [UIScreen mainScreen].bounds.size.height/2);
    [self.view.layer addSublayer:self.anilayer1];
    
    self.layer2 = [CAShapeLayer layer];
    self.layer2.frame = CGRectMake(0, 0, 60, 60);
    self.layer2.cornerRadius = 30;
    self.layer2.backgroundColor = [UIColor redColor].CGColor;
    self.layer2.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer2];
    self.layer2.position = CGPointMake(150, [UIScreen mainScreen].bounds.size.height/2);
    [self.view.layer addSublayer:self.anilayer2];


    
    self.layer3 = [CAShapeLayer layer];
    self.layer3.frame = CGRectMake(0, 0, 60, 60);
    self.layer3.cornerRadius = 30;
    self.layer3.backgroundColor = [UIColor redColor].CGColor;
    self.layer3.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer3];
    self.layer3.position = CGPointMake(240, [UIScreen mainScreen].bounds.size.height/2);
    [self.view.layer addSublayer:self.anilayer3];


    
    self.layer4 = [CAShapeLayer layer];
    self.layer4.frame = CGRectMake(0, 0, 60, 60);
    self.layer4.cornerRadius = 30;
    self.layer4.backgroundColor = [UIColor redColor].CGColor;
    self.layer4.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer4];
    self.layer4.position = CGPointMake(330, [UIScreen mainScreen].bounds.size.height/2);
    [self.view.layer addSublayer:self.anilayer4];


    
    self.animationLayer = [CAShapeLayer layer];
    self.animationLayer.frame = CGRectMake(0, 0, 50, 50);
    self.animationLayer.cornerRadius = 25;
    self.animationLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_animationLayer];
    self.animationLayer.position = CGPointMake(30, [UIScreen mainScreen].bounds.size.height/2);
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(10, [UIScreen mainScreen].bounds.size.height/2)],
                         [NSValue valueWithCGPoint:CGPointMake(60, [UIScreen mainScreen].bounds.size.height/2)],
                         [NSValue valueWithCGPoint:CGPointMake(150, [UIScreen mainScreen].bounds.size.height/2)],
                         [NSValue valueWithCGPoint:CGPointMake(240, [UIScreen mainScreen].bounds.size.height/2)],
                         [NSValue valueWithCGPoint:CGPointMake(330, [UIScreen mainScreen].bounds.size.height/2)],
                         [NSValue valueWithCGPoint:CGPointMake(380, [UIScreen mainScreen].bounds.size.height/2)],
                         ];
    animation.repeatCount = HUGE_VALL;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 4;
    animation.autoreverses = YES;
    [self.animationLayer addAnimation:animation forKey:@"move"];

}

- (CABasicAnimation *)getScaleAnimation{

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = @1.1;
    scaleAnimation.duration = 0.1;
    scaleAnimation.autoreverses = NO;
    return scaleAnimation;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
