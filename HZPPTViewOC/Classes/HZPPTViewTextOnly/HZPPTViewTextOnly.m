//
//  ZJPPTViewTextOnly.m
//  HZPPTViewOC
//
//  Created by LiuYihua on 2017/1/3.
//  Copyright © 2017年 LiuYihua. All rights reserved.
//

#import "HZPPTViewTextOnly.h"

@implementation HZPPTViewTextOnly

static NSString * const kTextOnlyCellId = @"HZPPTViewTextOnlyCell";

-(instancetype)initWithDelegate:(id<HZPPTViewDelegate>)delegate{

    if (self = [super initWithDelegate: delegate]) {
        self.pageControl.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)registerCellForCollectionView:(UICollectionView *)collectionView{

    [super registerCellForCollectionView:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:kTextOnlyCellId bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:kTextOnlyCellId];

}

-(UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath{
    [super dequeueReusableCellForCollectionView:collectionView withIndexPath:indexPath];
    HZPPTViewTextOnlyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTextOnlyCellId forIndexPath:indexPath];
    
    [self.delegate pptView:self setUpPageCell:cell withIndex:indexPath.row];
    
    return cell;


}

// 改变当前下标的时候, 调用代理方法设置新数据
- (void)currentPageDidChange:(NSInteger)currentPage {
    [super currentPageDidChange:currentPage];
    NSLog(@"%ld --- %ld", self.pages, self.currentPage);
}

@end
