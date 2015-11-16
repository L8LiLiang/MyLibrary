//
//  L8DataController.m
//  下拉动画
//
//  Created by 李亮 on 15/6/14.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8DataController.h"
#import "L8CollectionViewCell.h"

@interface L8DataController ()
@property (strong, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) UIView *infoView;
@property (strong, nonatomic) CAShapeLayer *loadLayer;
@property (strong, nonatomic) CAShapeLayer *ingLayer;
@property (assign, nonatomic) BOOL loading;
@property (assign, nonatomic) BOOL viewLoaded;
@property (assign, nonatomic) CGFloat offset;
@end

@implementation L8DataController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.collectionView.scrollEnabled = YES;
    
    [self makeLayer];
    
    [self.loadLayer addAnimation:[self loadAnimation] forKey:@"Write that word"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewLoaded = YES;
}

-(NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray arrayWithObjects:@"1",@"2",@"34",@"4",@"5",@"6",@"1",@"2",@"34",@"4",@"5",@"6",@"1",@"2",@"34",@"4",@"5",@"6",@"1",@"2",@"34",@"4",@"5",@"6", nil];
    }
    return _datas;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    CGFloat offset = scrollView.contentOffset.y + self.collectionView.contentInset.top;
    
    if (offset < 0 && !self.loading && self.isViewLoaded) {
        CGFloat threshold = self.infoView.bounds.size.height + 20;
        CGFloat fractionDragged = -offset/threshold;
        
        self.loadLayer.timeOffset = MIN(1.0, fractionDragged);
        
        if (fractionDragged >= 1.0) {
            [self startLoading];
        }
    }
}

-(void)startLoading
{
    self.loading = YES;
    
    CGFloat contentInset = self.collectionView.contentInset.top;
    CGFloat contentOffset = -self.collectionView.contentOffset.y;
    self.offset = contentOffset;
    // inset the top to keep the loading indicator on screen
    self.collectionView.contentInset = UIEdgeInsetsMake(contentInset + contentOffset, 0, 0, 0);

    self.collectionView.scrollEnabled = NO;
    
    CABasicAnimation *ani = [self ingAnimation];
    ani.delegate = self;
    [self.ingLayer addAnimation:ani forKey:@"loading"];


}

-(void)animationDidStart:(CAAnimation *)anim
{
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CGFloat contentInset = self.collectionView.contentInset.top;
    self.collectionView.contentInset = UIEdgeInsetsMake(contentInset - self.offset, 0, 0, 0);
    
    self.collectionView.scrollEnabled = YES;
    [self.ingLayer removeAllAnimations];
    self.loadLayer.timeOffset = 0;
    self.loading = NO;

}


-(CABasicAnimation *)loadAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    return animation;
}

-(CABasicAnimation *)ingAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    return animation;
}


-(void)makeLayer
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -40, 200, 40)];
    self.infoView = view;
    [self.collectionView addSubview:view];
    
    CAShapeLayer *loadLayer = [[CAShapeLayer alloc] init];
    loadLayer.path = [self loadPath];
    loadLayer.speed = 0;
    loadLayer.strokeColor = [UIColor blackColor].CGColor;
    loadLayer.fillColor = [UIColor clearColor].CGColor;
    loadLayer.lineCap = kCALineCapRound;
    loadLayer.lineJoin = kCALineJoinRound;
    loadLayer.lineWidth = 5;
    loadLayer.position = CGPointMake(70, 0);
    loadLayer.strokeEnd = 0;
    [self.infoView.layer addSublayer:loadLayer];
    
    CAShapeLayer *ingLayer = [[CAShapeLayer alloc] init];
    ingLayer.path = [self ingPath];
    //ingLayer.speed = 0;
    ingLayer.strokeColor = [UIColor blackColor].CGColor;
    ingLayer.fillColor = [UIColor clearColor].CGColor;
    ingLayer.lineCap = kCALineCapRound;
    ingLayer.lineJoin = kCALineJoinRound;
    ingLayer.lineWidth = 5;
    ingLayer.position = CGPointMake(70, 0);
    ingLayer.strokeEnd = 0;
    [self.infoView.layer addSublayer:ingLayer];
    
    self.loadLayer = loadLayer;
    self.ingLayer = ingLayer;
    
    //self.infoView.hidden = YES;
}

- (CGPathRef)loadPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    // load
    CGPathMoveToPoint(path,     NULL, 7.50878897, 25.2871097);
    CGPathAddCurveToPoint(path, NULL, 7.50878897, 25.2871097,  21.7333976, 26.7812495, 29.6894527, 20.225586);
    CGPathAddCurveToPoint(path, NULL, 37.6455074, 13.6699219,  39.367189,  3.85742195, 31.9697262, 1.25976564);
    CGPathAddCurveToPoint(path, NULL, 24.5722639, -1.33789083, 21.99707,   10.9072268, 21.99707,   22.2255862);
    CGPathAddCurveToPoint(path, NULL, 21.9970685, 33.5439456,  15.9355469, 45.8212894, 8.99707031, 47.7294922);
    CGPathAddCurveToPoint(path, NULL, 2.05859375, 49.637695,   3.67187498, 44.0332034, 7.50878897, 44.0332034);
    CGPathAddCurveToPoint(path, NULL, 11.3457029, 44.0332034,  16.9277345, 44.234375,  25.5234372, 47.7294925);
    CGPathAddCurveToPoint(path, NULL, 30.55635,   49.7759358,  37.9023439, 49.5410159, 44.1259762, 35.9140628);
    CGPathAddCurveToPoint(path, NULL, 50.349609,  22.2871097,  55.3105465, 25.2871099, 60.7128903, 25.2871097);
    CGPathAddCurveToPoint(path, NULL, 66.481445,  25.2871097,  56.192383,  22.6435549, 50.8017578, 26.6455078);
    CGPathAddCurveToPoint(path, NULL, 45.4111325, 30.6474606,  43.4619148, 37.8193362, 46.0097656, 43.7333984);
    CGPathAddCurveToPoint(path, NULL, 48.5576169, 49.6474606,  57.0488304, 50.0810555, 61.8876968, 43.0097659);
    CGPathAddCurveToPoint(path, NULL, 66.7265637, 35.9384765,  65.6816424, 31.5634772, 64.4834,    27.8232425);
    CGPathAddCurveToPoint(path, NULL, 63.2851574, 24.0830078,  59.8876972, 27.8076178, 59.8876968, 31.4882815);
    CGPathAddCurveToPoint(path, NULL, 59.8876965, 35.1689453,  69.1025406, 37.2509768, 74.9531265, 32.7333987);
    CGPathAddCurveToPoint(path, NULL, 80.8037132, 28.2158207,  80.1298793, 27.0527347, 84.4970703, 25.3574219);
    CGPathAddCurveToPoint(path, NULL, 88.8642613, 23.6621091,  93.7460906, 25.37793,   96.1650391, 28.8349609);
    CGPathAddCurveToPoint(path, NULL, 96.1650391, 28.8349609,  91.6679688, 24.28711,   88.085941,  24.2871097);
    CGPathAddCurveToPoint(path, NULL, 84.5039132, 24.2871093,  74.9824181, 33.0332029, 78.5166016, 43.3417969);
    CGPathAddCurveToPoint(path, NULL, 82.0507847, 53.6503909,  92.167965,  42.5078128, 95.0117188, 38.9140625);
    CGPathAddCurveToPoint(path, NULL, 97.8554722, 35.3203122,  100.327144, 27.9042972, 100.327148, 23.3740234);
    CGPathAddCurveToPoint(path, NULL, 100.327152, 18.8437497,  96.499996,  26.5527347, 96.5,       32.7333984);
    CGPathAddCurveToPoint(path, NULL, 96.5000035, 38.9140622,  92.6337871, 53.1660163, 101.700195, 46.0400391);
    CGPathAddCurveToPoint(path, NULL, 110.766605, 38.9140622,  112.455075, 29.5751958, 118.345703, 26.9746094);
    CGPathAddCurveToPoint(path, NULL, 124.236332, 24.3740231,  129.221685, 27.5800787, 131.216798, 30.1386722);
    CGPathAddCurveToPoint(path, NULL, 131.216798, 30.1386722,  125.394529, 25.9746094, 121.82422,  25.9746097);
    CGPathAddCurveToPoint(path, NULL, 118.253911, 25.9746099,  110.588871, 32.4130862, 112.661136, 41.7500003);
    CGPathAddCurveToPoint(path, NULL, 114.733402, 51.0869143,  119.810543, 48.9121097, 125.347656, 43.0097656);
    CGPathAddCurveToPoint(path, NULL, 130.884769, 37.1074216,  137.702153, 21.0126953, 139.335938, 12.4980469);
    CGPathAddCurveToPoint(path, NULL, 140.969722, 3.98339847,  140.637699,-2.27636688, 136.845703, 7.984375);
    CGPathAddCurveToPoint(path, NULL, 134.586089, 14.0986513,  131.676762, 31.5527347, 129.884769, 38.9140628);
    CGPathAddCurveToPoint(path, NULL, 128.092777, 46.2753909,  130.551236, 50.2217745, 135.211914, 46.2753906);
    CGPathAddCurveToPoint(path, NULL, 146.745113, 36.5097659,  142.116211, 40.75,      142.116211, 40.75);
    
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big and I didn't feel like redoing it :D
    return CGPathCreateCopyByTransformingPath(path, &t);
}

- (CGPathRef)ingPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    // ing (minus dot)
    CGPathMoveToPoint(path,     NULL, 139.569336, 42.9423837);
    CGPathAddCurveToPoint(path, NULL, 139.569336, 42.9423837, 149.977539, 32.9609375, 151.100586, 27.9072266);
    CGPathAddCurveToPoint(path, NULL, 152.223633, 22.8535156, 149.907226, 21.5703124, 148.701172, 26.5419921);
    CGPathAddCurveToPoint(path, NULL, 147.495117, 31.5136718, 142.760742, 50.8046884, 149.701172, 48.2763681);
    CGPathAddCurveToPoint(path, NULL, 156.641602, 45.7480478, 166.053711, 33.5791017, 167.838867, 29.5136719);
    CGPathAddCurveToPoint(path, NULL, 169.624023, 25.4482421, 169.426758, 20.716797,  167.455078, 26.1152344);
    CGPathAddCurveToPoint(path, NULL, 165.483398, 31.5136718, 165.618164, 42.9423835, 163.97168,  48.2763678);
    CGPathAddCurveToPoint(path, NULL, 163.97168,  48.2763678, 163.897461, 41.4570313, 168.141602, 35.9375);
    CGPathAddCurveToPoint(path, NULL, 172.385742, 30.4179687, 179.773438, 21.9091796, 183.285645, 26.6875);
    CGPathAddCurveToPoint(path, NULL, 186.797851, 31.4658204, 177.178223, 48.2763684, 184.285645, 48.2763678);
    CGPathAddCurveToPoint(path, NULL, 191.393066, 48.2763678, 196.006836, 38.8701172, 198.850586, 34.0449218);
    CGPathAddCurveToPoint(path, NULL, 201.694336, 29.2197264, 207.908203, 19.020508,  216.71875,  28.4179687);
    CGPathAddCurveToPoint(path, NULL, 216.71875,  28.4179687, 211.086914, 23.5478516, 206.945312, 24.6738281);
    CGPathAddCurveToPoint(path, NULL, 202.803711, 25.7998046, 194.8125,   40.1455079, 201.611328, 47.2763672);
    CGPathAddCurveToPoint(path, NULL, 208.410156, 54.4072265, 220.274414, 30.9111327, 221.274414, 26.6874999);
    CGPathAddCurveToPoint(path, NULL, 222.274414, 22.4638672, 220.005859, 20.3759766, 218.523438, 28.5419922);
    CGPathAddCurveToPoint(path, NULL, 217.041016, 36.7080077, 216.630859, 64.7705084, 209.121094, 71.012696);
    CGPathAddCurveToPoint(path, NULL, 201.611328, 77.2548835, 197.109375, 65.0654303, 202.780273, 60.9287116);
    CGPathAddCurveToPoint(path, NULL, 208.451172, 56.7919928, 224.84668,  51.0244147, 228.638672, 38.6855466);
    
    // dot
    CGPathMoveToPoint(path,     NULL, 153.736328, 14.953125);
    CGPathAddCurveToPoint(path, NULL, 153.736328, 14.953125,  157.674805, 12.8178626, 155.736328, 10.2929688);
    CGPathAddCurveToPoint(path, NULL, 153.797852, 7.76807493, 151.408203, 12.2865614, 152.606445, 14.9531252);
    
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big and I didn't feel like redoing it :D
    return CGPathCreateCopyByTransformingPath(path, &t);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    L8CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.label.text = self.datas[indexPath.item];
    
    return cell;
}


@end
