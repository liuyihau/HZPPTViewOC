//
//  HZPPTViewController.h
//  HZPPTViewOC
//
//  Created by LiuYihua on 2016/12/27.
//  Copyright © 2016年 LiuYihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZPPTViewOC;

//PageControl

/**
 PageControl  位置描述
 */
typedef NS_ENUM(NSInteger,HZPPTViewPageControlPosition) {

    HZPPTViewPageControlPositionBottomCenter,
    HZPPTViewPageControlPositionBottomLeft,
    HZPPTViewPageControlPositionBottomRight,
    HZPPTViewPageControlPositionTopCenter,
    HZPPTViewPageControlPositionTopLeft,
    HZPPTViewPageControlPositionTopRight,

};


@protocol HZPPTViewDelegate <NSObject>

/**
 *  必须实现的代理方法, 返回总页数
 *
 *  @param pptView pptView
 *
 *  @return 返回总页数
 */
- (NSInteger)numberOfPagesForPPTView:(HZPPTViewOC *)pptView;

/**
 *  设置cell的数据
 *
 *  @param pptView pptView
 *  @param cell    cell的类型由注册的时候决定, 需要转换为相应的类型来使用
 *  @param index   index
 */
- (void)pptView:(HZPPTViewOC *)pptView setUpPageCell:(UICollectionViewCell *)cell withIndex:(NSInteger)index;

@optional

/**
 *  设置每一个页面的文字  --- 预留给子类使用 可以参见 ZJPPTViewCustom 中
 *  当然如果需要其他的代理方法来设置数据, 可能就需要在子类中自己定义新的代理和代理方法了
 *
 *  @param pptView   pptView
 *  @param label     label
 *  @param index     index
 */
- (void)pptView:(HZPPTViewOC *)pptView setUpTextLabel:(UILabel *)label withIndex:(NSInteger)index;

/**
 响应点击当前页

 @param pptView view
 @param index 被点击的index
 */
- (void)pptView:(HZPPTViewOC *)pptView didSelectPageForIndex:(NSInteger)index;
/**
 滚动到当前页

 @param pptView view
 @param currentIndex currentIndex
 */
- (void)pptView:(HZPPTViewOC *)pptView didScrollToCurrentIndex:(NSInteger)currentIndex;

@end

@interface HZPPTViewOC : UIView

@property (nonatomic, weak) id<HZPPTViewDelegate>delegate;

/** pageControl 的位置 默认为下面居中显示 */
@property (assign, nonatomic) HZPPTViewPageControlPosition pageControlPositon;
/** 滚动的时间间隔 默认为3s */
@property (assign, nonatomic) NSTimeInterval scrollDuration;
/** 滚动方向 水平或者竖直滚动 默认为水平方向滚动 */
@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
/** collectionView 只读*/
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
/** pageControl 只读*/
@property (strong, nonatomic, readonly) UIPageControl *pageControl;
/** 总共的页数 只读*/
@property (assign, nonatomic, readonly) NSInteger pages;
/** 当前的页数 只读*/
@property (assign, nonatomic, readonly) NSInteger currentPage;

/**
 *  初始化方法
 *
 *  @param delegate 代理 -- 必须实现代理中的两个方法(设置数据的代理方法对应的二选一)
 *
 *  @return ZJPPTViewOC
 */
-(instancetype)initWithDelegate:(id<HZPPTViewDelegate>)delegate;
/**
 *  重新加载所有内容
 */
- (void)reload;
/**
 *  为collectionView注册cell, 重写的时候一定要先调用父类的方法,详见示例
 *
 *  @param collectionView  collectionView
 */
- (void)registerCellForCollectionView:(UICollectionView *)collectionView;
/**
 *  为collectionView设置cell, 重写的时候一定要先调用父类的方法,详见示例
 *
 *  @param collectionView collectionView
 */
- (UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;
/**
 *  当前的页数正在改变 为了方便子类重写获取到页数的改变
 *
 *  @param currentPage 当前页数
 */
- (void)currentPageDidChange:(NSInteger)currentPage;

@end
