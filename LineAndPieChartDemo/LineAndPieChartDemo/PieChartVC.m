//
//  PieChartVC.m
//  LineAndPieChartDemo
//
//  Created by Krishana on 6/22/16.
//  Copyright © 2016 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "PieChartVC.h"

#define CHART_RADIUS 80
#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)
@interface PieChartVC ()
{
    CAShapeLayer *shapeLayer;
}
@end

@implementation PieChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(self.view.center.x + CHART_RADIUS, self.view.center.y )];
//    [path addArcWithCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:CHART_RADIUS startAngle:0 endAngle:2*M_PI clockwise:YES];
//
//   // [linePath addLineToPoint:CGPointMake((NUMBER_OF_DAYS + 1) * HORIZONTAL_INTER_SPACING, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW)];
//    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
//    shapeLayer1.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer1.fillColor = [UIColor redColor].CGColor;
//    shapeLayer1.lineWidth = 2;
//    shapeLayer1.lineJoin = kCALineJoinRound;
//    shapeLayer1.lineCap = kCALineCapRound;
//    shapeLayer1.path = path.CGPath;
//    [self.view.layer addSublayer:shapeLayer1];
    
    NSArray *chartArray = @[
                            @{
                                @"color" : [UIColor greenColor],
                                @"value" : @"40"
                             },
                            @{
                                @"color" : [UIColor orangeColor],
                                @"value" : @"30"
                                },
                            @{
                                @"color" : [UIColor blueColor],
                                @"value" : @"20"
                                },
                            @{
                                @"color" : [UIColor grayColor],
                                @"value" : @"10"
                                }
                            ];
    
    [self drawPieChartFromArray:chartArray];
}


-(void) drawPieChartFromArray:(NSArray *)chartArr
{
    float startAngle = 0;
    for (int i = 0; i< chartArr.count ; i++)
    {
        
        UIBezierPath *path = [UIBezierPath bezierPath];

        [path moveToPoint:CGPointMake(self.view.center.x, self.view.center.y)];

        float value = [[[chartArr objectAtIndex:i] objectForKey:@"value"] floatValue];
        UIColor *areaColor = (UIColor *)[[chartArr objectAtIndex:i] objectForKey:@"color"];
        CGFloat endAngle = startAngle + DEGREES_RADIANS(3.6*value);
        NSLog(@"start->%f\nEnd->%f",startAngle,endAngle);
        [path addArcWithCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:CHART_RADIUS startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        startAngle = startAngle + DEGREES_RADIANS(3.6*value);

        shapeLayer = [CAShapeLayer layer];
        shapeLayer.name = [NSString stringWithFormat:@"%d", i];
        shapeLayer.strokeColor = areaColor.CGColor;
        shapeLayer.fillColor = areaColor.CGColor;
        shapeLayer.lineWidth = 0;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.path = path.CGPath;
        [self.view.layer addSublayer:shapeLayer];
    }

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (id sublayer in self.view.layer.sublayers)
    {
        if ([sublayer isKindOfClass:[CAShapeLayer class]])
        {
            CAShapeLayer *shapeLayer1 = sublayer;
            NSLog(@"layer name-> %@", shapeLayer1.name);
            
            if ([shapeLayer1.name isEqualToString:@"1"])
            {
                NSLog(@"layer path-> %@", shapeLayer1.path);
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
