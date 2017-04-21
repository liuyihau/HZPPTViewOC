//
//  HZViewController.m
//  HZPPTViewOC
//
//  Created by liuyihua2015@sina.com on 04/21/2017.
//  Copyright (c) 2017 liuyihua2015@sina.com. All rights reserved.
//

#import "HZViewController.h"
#import "HZPPTViewDefault.h"
#import "HZPPTViewCustom.h"
#import "HZPPTViewTextOnly.h"

@interface HZViewController ()<HZPPTViewDelegate>{
    
    
    
}
@property (strong, nonatomic) HZPPTViewDefault *defaultPPT;
@property (nonatomic, strong) HZPPTViewCustom * customPPT;
@property (nonatomic, strong) HZPPTViewTextOnly * textOnlyPPT;
@end

@implementation HZViewController

//数据总数
NSInteger  numbers = 4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _defaultPPT = [[HZPPTViewDefault alloc] initWithDelegate:self];
    _defaultPPT.pageControlPositon = HZPPTViewPageControlPositionBottomRight;
    _defaultPPT.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //    _defaultPPT.scrollDirection = UICollectionViewScrollDirectionVertical;
    _defaultPPT.frame = CGRectMake(0.f, 40.f, self.view.bounds.size.width, 200);
    [self.view addSubview: _defaultPPT];
    
    _customPPT = [[HZPPTViewCustom alloc] initWithDelegate:self];
    _customPPT.pageControlPositon = HZPPTViewPageControlPositionBottomRight;
    _customPPT.frame = CGRectMake(0.f, 260, self.view.bounds.size.width, 200);
    [self.view addSubview:_customPPT];
    
    _textOnlyPPT = [[HZPPTViewTextOnly alloc] initWithDelegate:self];
    _textOnlyPPT.frame = CGRectMake(0.f, 480, self.view.bounds.size.width, 60);
    _textOnlyPPT.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:_textOnlyPPT];

}

//设置数据源
- (NSInteger)numberOfPagesForPPTView:(HZPPTViewOC *)pptView {
    return numbers;
}

- (void)pptView:(HZPPTViewOC *)pptView setUpPageCell:(UICollectionViewCell *)cell withIndex:(NSInteger)index {
    if (pptView == _defaultPPT) {
        HZPPTViewDefaultCell *defaultCell = (HZPPTViewDefaultCell *)cell;
        // 可自定义文字属性 ...
        //            defaultCell.textLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        //            defaultCell.textLabel.textAlignment = NSTextAlignmentCenter;
        //            defaultCell.textLabel.textColor = [UIColor whiteColor];
        
        if (index == numbers) {
            
            defaultCell.textLabel.text = [NSString stringWithFormat:@"    这是第: 0 页"];
            
        }else{
            
            defaultCell.textLabel.text = [NSString stringWithFormat:@"    这是第: %ld 页", index];
        }
        
        
        
        // 设置图片  网络图片, 可自由使用SDWebimage等来加载
        if (index%2 == 0) {
            UIImage *image = [UIImage imageNamed:@"1"];
            defaultCell.imageView.image = image;
        }
        else {
            UIImage *image = [UIImage imageNamed:@"2"];
            defaultCell.imageView.image = image;
        }
        
    }
    if (pptView == _customPPT) {
        HZPPTViewCustomCell *customCell = (HZPPTViewCustomCell *)cell;
        if (index%2 == 0) {
            UIImage *image = [UIImage imageNamed:@"1"];
            customCell.imageView.image = image;
        }
        else {
            UIImage *image = [UIImage imageNamed:@"2"];
            customCell.imageView.image = image;
        }
    }
    
    if (pptView == _textOnlyPPT) {
        HZPPTViewTextOnlyCell *textCell = (HZPPTViewTextOnlyCell *)cell;
        textCell.backgroundColor = [UIColor yellowColor];
        if (index == numbers) {
            
            textCell.textLabel.text = [NSString stringWithFormat:@"    这是第: 0 页"];
            
        }else{
            
            textCell.textLabel.text = [NSString stringWithFormat:@"    这是第: %ld 页", index];
        }
        
        textCell.textLabel.textColor = [UIColor purpleColor];
        
    }
}

- (void)pptView:(HZPPTViewOC *)pptView setUpTextLabel:(UILabel *)label withIndex:(NSInteger)index {
    // 可自定义文字属性 ...
    //    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"    这是第: %ld 页", index];
    
    
}


- (void)pptView:(HZPPTViewOC *)pptView didSelectPageForIndex:(NSInteger)index {
    NSLog(@"点击了 %ld", index);
    //    [ZJProgressHUD showStatus:[NSString stringWithFormat:@"点击了 %ld", index] andAutoHideAfterTime:1.0];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
