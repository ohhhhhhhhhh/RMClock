//
//  ViewController.m
//  RMClock
//
//  Created by ohhh on 2017/6/17.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "ViewController.h"


#define clockImageViewW  self.clockImageV.bounds.size.width


#define perSecondA  6
#define perMinuteA  6
#define perHourA  30
#define perHourMinteA 0.5


#define angle2radion(a)  ((a)/180.f*M_PI)


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockImageV;

@property (nonatomic,  weak) CALayer * secondLayer;

@property (nonatomic,  weak) CALayer * minuteLayer;

@property (nonatomic,  weak) CALayer * hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setUpHourLayer];
    
    [self setUpMinuteLayer];
    
    [self setUpSecondLayer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [self timeChange];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //    CABasicAnimation * anim = [CABasicAnimation animation];
    //
    //    anim.keyPath = @"transform.scale";
    //
    //    anim.toValue = @0.5;
    
    //    anim.repeatCount = MAXFLOAT;
    
    //    anim.removedOnCompletion = NO;
    //
    //    anim.fillMode = kCAFillModeForwards;
    //
    //    [self.clockImageV.layer addAnimation:anim forKey:nil];
    
    
    CAKeyframeAnimation * key = [CAKeyframeAnimation animation];
    
    key.keyPath = @"position";
    
    key.values = @[@(200)];
    
    [self.clockImageV.layer addAnimation:key forKey:nil];
}


- (void)timeChange{
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents * cmp = [calendar components:NSCalendarUnitSecond | kCFCalendarUnitMinute | kCFCalendarUnitHour fromDate:[NSDate date]];
    
    
    NSInteger second = cmp.second;
    
    CGFloat secondA = second * perSecondA;
    
    self.secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    
    NSInteger minute = cmp.minute;
    
    CGFloat minuteA =  minute * perMinuteA;
    
    self.minuteLayer.transform = CATransform3DMakeRotation(angle2radion(minuteA), 0, 0, 1);
    
    
    NSInteger hour = cmp.hour;
    
    CGFloat hourA = hour * perHourA + minute * perHourMinteA;
    
    self.hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}

- (void)setUpHourLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(clockImageViewW*0.5, clockImageViewW*0.5);
    
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 1.f, clockImageViewW*0.5-40);
    
    [self.clockImageV.layer addSublayer:layer];
    
    self.hourLayer = layer;
}

- (void)setUpMinuteLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(clockImageViewW*0.5, clockImageViewW*0.5);
    
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 1.f, clockImageViewW*0.5-20);
    
    [self.clockImageV.layer addSublayer:layer];
    
    self.minuteLayer = layer;
}

- (void)setUpSecondLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(clockImageViewW*0.5, clockImageViewW*0.5);
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 1.f, clockImageViewW*0.5-20);
    
    [self.clockImageV.layer addSublayer:layer];
    
    self.secondLayer = layer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
