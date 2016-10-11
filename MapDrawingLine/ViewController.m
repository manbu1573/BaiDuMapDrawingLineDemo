//
//  ViewController.m
//  MapDrawingLine
//
//  Created by 李荣建 on 2016/10/11.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
//#import "CustomOverlayView.h"
//#import "CustomOverlay.h"
typedef struct {
    GLfloat x;
    GLfloat y;
}GLPoint;
@interface ViewController ()<BMKMapViewDelegate>
{
    
    BMKMapView* _mapView;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController


-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [_mapView setZoomLevel:12];//设置地图放大比例
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _mapView = [BMKMapView new];
    _mapView.frame = self.view.frame;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [self.view addSubview:_mapView];
    [self lodeTheData];
}
- (void) lodeTheData
{
    //加载的假数据
    for (int i = 0; i < 100; i++) {
        
        [self.dataArr addObject: @{@"latitude":[NSString stringWithFormat:@"39.9%d",i] ,@"longitude":[NSString stringWithFormat:@"116.4%d",i]}];
        
    }
    [self layoutDry];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)layoutDry
{
    
    CLLocationCoordinate2D coors[1000] = {0};//coors要设置一个比较大的数
    for (int i = 0;  i < _dataArr.count; i++) {
        coors[i].latitude = [[_dataArr[i] valueForKey:@"latitude"] doubleValue];
        coors[i].longitude = [[_dataArr[i] valueForKey:@"longitude"] doubleValue];
    }
    BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coors count:_dataArr.count];
    [_mapView addOverlay:polyline];
}
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView *polyLineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polyLineView.strokeColor = [UIColor redColor];//设置线的颜色
        polyLineView.lineWidth = 5.0;//设置线宽
        return polyLineView;
    }
    return nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    _mapView = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
