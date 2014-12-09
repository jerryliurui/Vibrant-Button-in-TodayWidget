//
//  NTESNBTWVibrantButton.m
//  NewsBoard
//
//  Created by 刘瑞 on 14/11/26.
//  Copyright (c) 2014年 NetEase.com, Inc. All rights reserved.
//

#import "TWVibrantButton.h"

@implementation TWVibrantButton
{
    UIVisualEffectView            *_visualEffectView;
    UILabel                       *_titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title state:(TodayWidgetVibrantButtonState)state
{
    if (self = [super initWithFrame:frame]) {
        self.text = title;
        self.state = state;
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        [self addGesture];
        [self initSubViews];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    _text = text;
    _titleLabel.text = text;
}

-(void)setState:(TodayWidgetVibrantButtonState)state
{
    _state = state;
    if (state == TodayWidgetVibrantButtonSelected) {
        void(^buttonTap)(void) = ^(void)
        {
            _titleLabel.textColor = [UIColor blackColor];
            _visualEffectView.alpha = 0.7;
        };
        [UIView animateWithDuration:0.3 animations:buttonTap];
        
    }else
    {
        void(^buttonTap)(void) = ^(void)
        {
            _titleLabel.textColor = [UIColor whiteColor];
            _visualEffectView.alpha = 0.2;
        };
        [UIView animateWithDuration:0.3 animations:buttonTap];
    }
}

-(void)initSubViews
{
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [self addSubview:_visualEffectView];
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
}

-(void)layoutSubviews
{
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.layer.masksToBounds = YES;
    _visualEffectView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _titleLabel.frame = CGRectMake(0, self.bounds.size.height*0.08, self.bounds.size.width, self.bounds.size.height*0.8);
    _titleLabel.text = self.text;
    _titleLabel.font = self.font;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (_state == TodayWidgetVibrantButtonSelected) {
        _titleLabel.textColor = [UIColor blackColor];
        _visualEffectView.alpha = 0.7;
    }else
    {
        _titleLabel.textColor = [UIColor whiteColor];
        _visualEffectView.alpha = 0.2;
    }
}

//添加手势动作
-(void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didNTESNBTWTopicButton:)];
    [self addGestureRecognizer:tap];
}

//delegate方法
-(void)didNTESNBTWTopicButton: (UITapGestureRecognizer *)tap
{
    [self.delegate didTWVibrantButton:self atIndex:self.tag];
}

@end
