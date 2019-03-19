//
//  carameAnimeView.m
//  Photographing
//
//  Created by 家里人哭成一团 on 2019/3/18.
//  Copyright © 2019 xialei. All rights reserved.
//

#import "carameAnimeView.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
@implementation carameAnimeView
-(void)dealloc{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    CGFloat width = MAX(kWIDTH, kHEIGHT) * 1.5;
    CGFloat top = (width - kHEIGHT) / 2;
    CGFloat left = (width - kWIDTH) / 2;
    self = [super initWithFrame:CGRectMake(-left, -top, width, width)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _initSet];
        [self add];
    }
    return self;
}
- (void)_initSet{
    paths = @[[[UIBezierPath alloc] init],[[UIBezierPath alloc] init],[[UIBezierPath alloc] init],[[UIBezierPath alloc] init],[[UIBezierPath alloc] init],[[UIBezierPath alloc] init],[[UIBezierPath alloc] init],[[UIBezierPath alloc] init]];
    layers = @[[CAShapeLayer layer],[CAShapeLayer layer],[CAShapeLayer layer],[CAShapeLayer layer],[CAShapeLayer layer],[CAShapeLayer layer],[CAShapeLayer layer],[CAShapeLayer layer]];
    CGFloat w = MAX(kWIDTH, kHEIGHT) * 1.5;
    CGFloat x = w / (sqrt(2) + 2);
    CGFloat s = x * sqrt(2);
    
    CGPoint point1 = CGPointMake(x, 0);
    CGPoint point2 = CGPointMake(x+s, 0);
    CGPoint point3 = CGPointMake(w, x);
    CGPoint point4 = CGPointMake(w, x+s);
    CGPoint point5 = CGPointMake(x+s, w);
    CGPoint point6 = CGPointMake(x, w);
    CGPoint point7 = CGPointMake(0, x+s);
    CGPoint point8 = CGPointMake(0, x);
    
    
    points = @[[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3],[NSValue valueWithCGPoint:point4],[NSValue valueWithCGPoint:point5],[NSValue valueWithCGPoint:point6],[NSValue valueWithCGPoint:point7],[NSValue valueWithCGPoint:point8],];
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    scale = -0.2;
//    [self add];
//}
- (void)stopWave
{
    [self.waveDisplaylink invalidate];
    _waveDisplaylink = nil;
}

- (void)add{
    [self stopWave];
    scale = -0.2;
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(addWave)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)de{
    [self stopWave];
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(deWave)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)addWave
{
    scale += 0.05;//调节速度
    if (scale > 1.2) {
        if (self.block) {
            self.block(YES);
        }
        [self stopWave];
        [self performSelector:@selector(de) withObject:nil afterDelay:0.2];//黑屏间隔
    }
    [self setNeedsDisplay];
    
}
- (void)deWave
{
    scale -= 0.05;
    if (scale < -0.2) {
        [self stopWave];
        if (self.dblock) {
            self.dblock(YES);
        }
        [self removeFromSuperview];
        return;
    }
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self anime];
}
NSInteger realInt(NSInteger intt){
    if (intt < 0) {
        intt = intt + 8;
    }else if (intt >= 8){
        intt = intt - 8;
    }
    return intt;
}
- (void)anime{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:scale];

    for (int i = 0 ;i < 8;i++) {
        UIBezierPath *path = paths[i];
        CAShapeLayer *layer = layers[i];
        [self.layer addSublayer:layer];
        [path removeAllPoints];
        CGPoint point1 = [points[i] CGPointValue];
        
        NSInteger j = realInt(i+1);
        CGPoint point2 = [points[j] CGPointValue];

        NSInteger k = realInt(i-1);
        CGPoint point3 = [points[k] CGPointValue];
        
        NSInteger p = realInt(i-2);
        CGPoint point4 = [points[p] CGPointValue];
        
      
       //添加空隙
        CGFloat jg = 2;
        if (i == 0) {
            point1.x += jg;
            point2.x -= jg;
        }else if (i == 1){
            point1.x += jg;
            point2.y -= jg;
        }else if (i == 2){
            point1.y += jg;
            point2.y -= jg;
        }else if (i == 3){
            point1.y += jg;
            point2.x += jg;
        }else if (i == 4){
            point1.x -= jg;
            point2.x += jg;
        }else if (i == 5){
            point1.x -= jg;
            point2.y += jg;
        }else if (i == 6){
            point1.y -= jg;
            point2.y += jg;
        }else if (i == 7){
            point1.y -= jg;
            point2.x -= jg;
        }
        
        
        
        
        [path moveToPoint:point1];
        [path addLineToPoint:point2];
        
        
        
        NSInteger c = realInt(i-3);
        CGPoint pointC = [points[c] CGPointValue];
        
        NSInteger d = realInt(i-4);
        CGPoint pointD = [points[d] CGPointValue];
        
        point3.x += (pointC.x - point3.x) * scale;
        point3.y += (pointC.y - point3.y) * scale;
        
        point4.x += (pointD.x - point4.x) * scale;
        point4.y += (pointD.y - point4.y) * scale;

        
        CGPoint pointjd = jd(point2, point3, point1, point4);//获取两条线段的焦点
        [path addLineToPoint:pointjd];
        [path addLineToPoint:point1];


        layer.backgroundColor = [UIColor blackColor].CGColor;
        layer.path = path.CGPath;

        
    }

}
CGPoint jd(CGPoint a, CGPoint b, CGPoint c, CGPoint d){
    CGFloat denominator = (b.y - a.y)*(d.x - c.x) - (a.x - b.x)*(c.y - d.y);
    if (denominator==0) {
        return CGPointZero;
    }
    CGFloat x = ( (b.x - a.x) * (d.x - c.x) * (c.y - a.y)
             + (b.y - a.y) * (d.x - c.x) * a.x
             - (d.y - c.y) * (b.x - a.x) * c.x ) / denominator ;
    CGFloat y = -( (b.y - a.y) * (d.y - c.y) * (c.x - a.x)
              + (b.x - a.x) * (d.y - c.y) * a.y
              - (d.x - c.x) * (b.y - a.y) * c.y ) / denominator;
    if (
        (x - a.x) * (x - b.x) <= 0 && (y - a.y) * (y - b.y) <= 0
        && (x - c.x) * (x - d.x) <= 0 && (y - c.y) * (y - d.y) <= 0
        ){
        return CGPointMake(x, y);
    }
    return CGPointZero;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
