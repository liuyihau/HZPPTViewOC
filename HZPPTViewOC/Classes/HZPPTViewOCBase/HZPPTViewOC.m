//
//  HZPPTViewController.m
//  HZPPTViewOC
//
//  Created by LiuYihua on 2016/12/27.
//  Copyright © 2016年 LiuYihua. All rights reserved.
//

#import "HZPPTViewOC.h"

@interface HZPPTViewOC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>{


    CGPoint beginOffset;
    
}

@property (nonatomic, strong) UICollectionView * collectionView;

//总页数 有代理方法获取到
@property (nonatomic, assign) NSInteger  pages;

//当前页 重写setter 进行相关的配置
@property (nonatomic, assign) NSInteger currentPage;

//倒计时
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) UICollectionViewFlowLayout * collectionViewLayout;

@end

@implementation HZPPTViewOC


-(instancetype)initWithDelegate:(id<HZPPTViewDelegate>)delegate{
    
    self = [super init];
    if (self) {
        
        _delegate = delegate;
        
        [self commonInit];
        
    }
    return self;
    
}

-(void)commonInit{

    if (_delegate && [_delegate respondsToSelector:@selector(numberOfPagesForPPTView:)]) {
        self.pages = [_delegate numberOfPagesForPPTView:self];
    }
    else {
        NSAssert(NO, @"必须实现代理方法 numberOfPagesForPPTView: ");
    }
    
    _scrollDuration = 3.f;
    _pageControlPositon = HZPPTViewPageControlPositionBottomRight;
    _scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.currentPage = 0;
    
    //添加控件
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    //注册cell
    [self registerCellForCollectionView:self.collectionView];
    
    
    // 开启timer
    [self startTimer];
    
    

}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGSize pageControlSize = [self.pageControl sizeForNumberOfPages:self.pages];
    CGRect pageControlFrame = CGRectMake(0.f, 0.f, pageControlSize.width, pageControlSize.height);
    
    switch (self.pageControlPositon) {
        case HZPPTViewPageControlPositionTopCenter:
            pageControlFrame.origin.x = (self.bounds.size.width - pageControlFrame.size.width)*0.5;
            pageControlFrame.origin.y = 0.f;
            break;
        case HZPPTViewPageControlPositionTopLeft:
            pageControlFrame.origin.x = 20.f;
            pageControlFrame.origin.y = 0.f;
            break;
        case HZPPTViewPageControlPositionTopRight:
            pageControlFrame.origin.x = self.bounds.size.width - pageControlFrame.size.width - 20;
            pageControlFrame.origin.y = 0.f;
            break;
        case HZPPTViewPageControlPositionBottomCenter:
            pageControlFrame.origin.x = (self.bounds.size.width - pageControlFrame.size.width)*0.5;
            pageControlFrame.origin.y = self.bounds.size.height - pageControlFrame.size.height - 0.f;
            break;
        case HZPPTViewPageControlPositionBottomLeft:
            pageControlFrame.origin.x = 20.f ;
            pageControlFrame.origin.y = self.bounds.size.height - pageControlFrame.size.height;
            break;
        case HZPPTViewPageControlPositionBottomRight:
            pageControlFrame.origin.x = self.bounds.size.width - pageControlFrame.size.width - 20;
            pageControlFrame.origin.y = self.bounds.size.height - pageControlFrame.size.height;
            break;
    }
    self.pageControl.frame = pageControlFrame;
    self.collectionView.frame = self.bounds;

}



- (void)dealloc {
    [self stopTimer];
    NSLog(@"HZPPTCollectionView ----销毁");
}

// 将要准备销毁
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self stopTimer];
    }
}

#pragma mark - public methods

- (void)reload {
    [self.collectionView removeFromSuperview];
    [self.pageControl removeFromSuperview];
    self.collectionView = nil;
    self.pageControl = nil;
    [self commonInit];
}

//注册cell 子类实现
- (void)registerCellForCollectionView:(UICollectionView *)collectionView{
}


// 子类实现
- (UICollectionViewCell *)dequeueReusableCellForCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

// 子类实现
- (void)currentPageDidChange:(NSInteger)currentPage {
}

#pragma mark - UIScrollViewDelegate

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 记录初始偏移量
    beginOffset = scrollView.contentOffset;
    [self stopTimer];
}
// 松开手
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        CGFloat offsetX = scrollView.contentOffset.x;

        //向左滑
        if (offsetX > scrollView.contentSize.width - scrollView.bounds.size.width) {
            //滚动到最后一页
            //重置滚动开始的偏移量
            beginOffset.x = 0;
            offsetX = beginOffset.x;
            //设置滚动到第一页
            [scrollView setContentOffset:CGPointMake(beginOffset.x, 0) animated:NO];
            
        //向右滑
        }else if (offsetX < 0){
            
            //重置滚动开始的偏移量
            beginOffset.x = scrollView.contentSize.width - scrollView.bounds.size.width;
            offsetX = beginOffset.x;
            //设置滚动到最后一页
            [scrollView setContentOffset:CGPointMake(beginOffset.x, 0) animated:NO];
            
        
        }
        
        NSInteger tempIndex = offsetX/scrollView.bounds.size.width + 0.5;
        if (tempIndex >= _pages) {
            tempIndex = 0;
        }
        if (tempIndex != _currentPage) {
            self.currentPage = tempIndex;
        }
        
        
        
    }else{
    
    
        CGFloat offsetY = scrollView.contentOffset.y;
        
        //向上滑
        if (offsetY > scrollView.contentSize.height - scrollView.bounds.size.height) {
            //滚动到最后一页
            beginOffset.y = 0;
            offsetY = beginOffset.y;
            [scrollView setContentOffset:CGPointMake(0, beginOffset.y) animated:NO];
            
            
        }
        if (offsetY < 0) {//滚动到第一页
            
            beginOffset.y = scrollView.contentSize.height - scrollView.bounds.size.height;
            
            offsetY = beginOffset.y;
            
            [scrollView setContentOffset:CGPointMake(0, beginOffset.y) animated:NO];
            
        }
        
        
        NSInteger tempIndex = offsetY/scrollView.bounds.size.height + 0.5;
        if (tempIndex >= _pages) {
            tempIndex = 0;
        }
        if (tempIndex != _currentPage) {
            self.currentPage = tempIndex;
        }
        
        
    }
    
    

}


#pragma mark - NSTimerHandler
- (void)startTimer {

    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollDuration target:self selector:@selector(timerHander:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        //延时触发
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollDuration]];
    }



}


-(void)timerHander:(NSTimer*)timer{

    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
         [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.collectionView.bounds.size.width, 0.f) animated:YES];
        
    }else{
    
         [self.collectionView setContentOffset:CGPointMake(0.f, self.collectionView.contentOffset.y + self.collectionView.bounds.size.height) animated:YES];
    
    }
    
    

}


-(void)stopTimer{

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    

}
#pragma mark - UICollectionViewDelegate , UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _pages + 1;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    NSIndexPath * realIndexPath = indexPath;
    
    if (indexPath.row == _pages) { // 在最后一个后面添加第一个cell
        
          realIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        
    }
    
    UICollectionViewCell * cell = [self dequeueReusableCellForCollectionView:collectionView withIndexPath:realIndexPath];
    //设置数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(pptView:setUpPageCell:withIndex:)]) {
        
        [self.delegate pptView:self setUpPageCell:cell withIndex:indexPath.row];
        
    }
    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    NSIndexPath * realIndexPath = indexPath;
    
    if (indexPath.row == _pages) { // 在最后一个后面添加第一个cell
        
        realIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        
    }
    
    //设置数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(pptView:didSelectPageForIndex:)]) {
        
        [self.delegate pptView:self didSelectPageForIndex:realIndexPath.row];
        
    }

}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
}


#pragma mark - setter ---- getter

-(void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    
    if (_delegate && [_delegate respondsToSelector:@selector(pptView:didScrollToCurrentIndex:)]) {
        [_delegate pptView:self didScrollToCurrentIndex:currentPage];
    }
    [self currentPageDidChange:currentPage];
    self.pageControl.currentPage = currentPage;
    
    
}

-(void)setPages:(NSInteger)pages{
    _pages = pages;
    self.pageControl.numberOfPages = pages;

}

-(void)setPageControlPositon:(HZPPTViewPageControlPosition)pageControlPositon{
    _pageControlPositon = pageControlPositon;
    [self setNeedsLayout];

}

-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    self.collectionViewLayout.scrollDirection = scrollDirection;

}




/**
 lazy - collectionView
 */
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator  = NO;
        
        _collectionView = collectionView;
        
        
    }
    return _collectionView;
}

/**
 lazy - pageControl
 */
-(UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        UIPageControl * pageControl = [[UIPageControl alloc]init];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl = pageControl;
        
        
    }
    return _pageControl;
}
/**
 lazy
 */
-(UICollectionViewFlowLayout *)collectionViewLayout{
    
    if (!_collectionViewLayout) {
        
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionViewLayout.itemSize = CGSizeMake(100, 100);
        _collectionViewLayout.minimumLineSpacing = 0.f;
        _collectionViewLayout.minimumInteritemSpacing = 0.f;
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     
    }
    return _collectionViewLayout;
}


@end
