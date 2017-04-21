//
//  HZPPTViewDefault.m
//  HZPPTViewOC
//
//  Created by LiuYihua on 2017/1/3.
//  Copyright © 2017年 LiuYihua. All rights reserved.
//

#import "HZPPTViewDefault.h"



static NSString *const kCustomCellId = @"HZPPTViewCustomCell";

@implementation HZPPTViewDefault


-(instancetype)initWithDelegate:(id<HZPPTViewDelegate>)delegate{

    if (self = [super initWithDelegate: delegate]) {
        //添加自定义控制
        
    }

    return self;
    
}


//重写父类方法
-(void)registerCellForCollectionView:(UICollectionView *)collectionView{

    [super registerCellForCollectionView: collectionView];
    [collectionView registerClass:[HZPPTViewDefaultCell class] forCellWithReuseIdentifier:kCustomCellId];

}

-(UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath{


    [super dequeueReusableCellForCollectionView:collectionView withIndexPath:indexPath];
    HZPPTViewDefaultCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCustomCellId forIndexPath:indexPath];
    
    return cell;

}



@end
