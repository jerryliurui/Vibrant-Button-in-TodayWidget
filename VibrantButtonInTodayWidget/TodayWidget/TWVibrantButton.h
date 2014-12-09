//
//  NTESNBTWVibrantButton.h
//  NewsBoard
//
//  Created by 刘瑞 on 14/11/26.
//  Copyright (c) 2014年 NetEase.com, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TodayWidgetVibrantButtonSelected,
    TodayWidgetVibrantButtonUnselected
} TodayWidgetVibrantButtonState;

@class TWVibrantButton;
@protocol TWVibrantButtonDelegate <NSObject>

-(void)didTWVibrantButton:(TWVibrantButton *)vibrantButton atIndex:(NSInteger)index;

@end

@interface TWVibrantButton : UIView

@property (nonatomic, assign) TodayWidgetVibrantButtonState state;

@property (nonatomic , copy) NSString *text;

@property (nonatomic, weak) id <TWVibrantButtonDelegate> delegate;

@property (nonatomic , strong) UIFont *font;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title state:(TodayWidgetVibrantButtonState)state;

@end
