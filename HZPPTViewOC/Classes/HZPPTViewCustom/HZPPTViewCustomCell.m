//
//  HZPPTViewCustomCell.m
//  HZPPTViewOC
//
//  Created by LiuYihua on 2017/1/3.
//  Copyright © 2017年 LiuYihua. All rights reserved.
//

#import "HZPPTViewCustomCell.h"

@interface HZPPTViewCustomCell ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation HZPPTViewCustomCell


- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.imageView];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        _imageView = imageView;
    }
    return _imageView;
}


@end
