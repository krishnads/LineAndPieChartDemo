//
//  LineChartViewController.m
//  LineAndPieChartDemo
//
//  Created by Krishana on 6/22/16.
//  Copyright © 2016 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "LineChartViewController.h"
#define HORIZONTAL_INTER_SPACING 30.0f
#define VERTICAL_INTER_SPACING 40.0f
#define NUMBER_OF_DAYS 30
#define TOP_MARGIN_FROM_VIEW 200
#define BOTTOM_MARGIN_FROM_VIEW 20
#define LEFT_MARGIN_FROM_VIEW 100
#define POINT_WIDTH 5

@interface LineChartViewController ()

@property(strong) IBOutlet UIView *chartView;
@property(weak) IBOutlet UIScrollView *scrollView;

@end

@implementation LineChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _chartView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NUMBER_OF_DAYS * HORIZONTAL_INTER_SPACING + LEFT_MARGIN_FROM_VIEW * 3, self.scrollView.frame.size.height)];
    
    [self.scrollView addSubview:_chartView];
    
    self.scrollView.contentSize = CGSizeMake(NUMBER_OF_DAYS * HORIZONTAL_INTER_SPACING + LEFT_MARGIN_FROM_VIEW*3, self.scrollView.frame.size.height);
    
    NSLog(@"scroll height->%f",self.scrollView.frame.size.height);
    NSLog(@"chart height->%f",self.chartView.frame.size.height);

    UIBezierPath *verticalLinePath = [[UIBezierPath alloc] init];
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    
    //adding horizontal line
    [linePath moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW - 10, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW)];
    [linePath addLineToPoint:CGPointMake((NUMBER_OF_DAYS + 1) * HORIZONTAL_INTER_SPACING, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW)];
    
    //UILabel *hlabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN_FROM_VIEW - POINT_WIDTH - 50, ((_chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW) - (_chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW)) / 2, 30, 20)];
    
    UILabel *vlabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN_FROM_VIEW - POINT_WIDTH - 40, (self.scrollView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW) - VERTICAL_INTER_SPACING * 5 - 5, 40, 12)];
    vlabel.text = @"Ratings";
    vlabel.textAlignment = NSTextAlignmentCenter;
    vlabel.font = [UIFont systemFontOfSize:10.0f];
    [vlabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.view addSubview:vlabel];
    
    UILabel *hlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width/2 - 20, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW + 30, 30, 12)];
    hlabel.text = @"Dates";
    hlabel.textAlignment = NSTextAlignmentCenter;
    hlabel.font = [UIFont systemFontOfSize:10.0f];
    [self.view addSubview:hlabel];    
    
    //adding vertical line
    [verticalLinePath moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW, _chartView.frame.size.height + BOTTOM_MARGIN_FROM_VIEW)];
    [verticalLinePath addLineToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW, _chartView.frame.size.height - 10 * VERTICAL_INTER_SPACING)];

    //adding points for vertical line
    for (int i = 1; i <= 9; i++)
    {
        [verticalLinePath moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW - POINT_WIDTH, (self.scrollView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW) - VERTICAL_INTER_SPACING * i)];
        [verticalLinePath addLineToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW, (self.scrollView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW) - VERTICAL_INTER_SPACING * i)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN_FROM_VIEW - POINT_WIDTH - 10, (self.scrollView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW) - VERTICAL_INTER_SPACING * i - 5, 10, 10)];
        label.text = [NSString stringWithFormat:@"%d",i - 5];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:8.0f];
        [self.view addSubview:label];
    }

    //adding points for horizontal line
    for (int i = 1; i <= NUMBER_OF_DAYS; i++)
    {
        [linePath moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW + HORIZONTAL_INTER_SPACING * i, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW)];
        [linePath addLineToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW + HORIZONTAL_INTER_SPACING * i, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW + POINT_WIDTH)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN_FROM_VIEW + HORIZONTAL_INTER_SPACING * i - 10, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW + 10, 20, 10)];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:8.0f];
        [self.chartView addSubview:label];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = linePath.CGPath;
    [self.chartView.layer addSublayer:shapeLayer];
    
    CAShapeLayer *horizontalLayer = [CAShapeLayer layer];
    horizontalLayer.strokeColor = [UIColor redColor].CGColor;
    horizontalLayer.fillColor = [UIColor clearColor].CGColor;
    horizontalLayer.lineWidth = 2;
    horizontalLayer.lineJoin = kCALineJoinRound;
    horizontalLayer.lineCap = kCALineCapRound;
    horizontalLayer.path = verticalLinePath.CGPath;
    [self.view.layer addSublayer:horizontalLayer];
    
    [self drawPointsAndLineOnChart:nil];
}


-(void) drawPointsAndLineOnChart:(NSArray *)pointsArray
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    
   // [linePath moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW)];
    
    
    NSArray *pArray = @[@"0",@"-4",@"3",@"-1",@"2",@"-3",@"4",@"-3",@"3",@"0",@"1",@"-4",@"2",@"3",@"-2",@"0",@"-4",@"3",@"-1",@"2",@"-3",@"4",@"-3",@"3",@"0",@"1",@"-4",@"2",@"3",@"-2"];
    
    NSLog(@"count->%ld",pArray.count);

    for (int i = 0; i < pArray.count; i++)
    {
        NSInteger pointValue = [[pArray objectAtIndex:i] integerValue];
        
        if (i == 0)
        {
            [linePath moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW + HORIZONTAL_INTER_SPACING * (i+1) + 1, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW - VERTICAL_INTER_SPACING * (pointValue + 5))];
        }
        
        [path moveToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW + HORIZONTAL_INTER_SPACING * (i+1) + 1, _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW - VERTICAL_INTER_SPACING * (pointValue + 5))];

        [path addArcWithCenter:CGPointMake(LEFT_MARGIN_FROM_VIEW + (HORIZONTAL_INTER_SPACING * (i+1)) - 1, (_chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW - VERTICAL_INTER_SPACING * (pointValue + 5)) + 1) radius:3 startAngle:0 endAngle:2*M_PI clockwise:YES];
        
        [linePath addLineToPoint:CGPointMake(LEFT_MARGIN_FROM_VIEW + HORIZONTAL_INTER_SPACING * (i+1), _chartView.frame.size.height - BOTTOM_MARGIN_FROM_VIEW - VERTICAL_INTER_SPACING * (pointValue + 5))];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.chartView.layer addSublayer:shapeLayer];
    
    //Line layer path
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor blueColor].CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 2;
    lineLayer.lineJoin = kCALineJoinRound;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.path = linePath.CGPath;
    [self.chartView.layer addSublayer:lineLayer];
}


- (void)didReceiveMemoryWarning
{
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
