//
//  TodayViewController.m
//  TodayWidget
//
//  Created by JerryLiu on 14/12/9.
//  Copyright (c) 2014年 JerryLiu. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define Topic_Button_Width 64
#define Topic_Button_Height 30
#define Topic_Button_Top_Gap 16
#define Topic_Button_Left_Gap 18

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController
{
    //栏目按钮的数组
    NSMutableArray *_buttonArrays;
    
    //涉及界面元素、文字字号设置
    CGFloat _topicFontSize;
    CGFloat _newsTitleFontSize;
    CGFloat _topicButtonWidth;
    CGFloat _topicButtonHeight;
    CGFloat _topicButtonRightGap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)configContent
{
    self.view.backgroundColor = [UIColor clearColor];
    [self setPreferredContentSize:CGSizeMake(0, 90)];
    if (self.view.frame.size.width == 320.f) {
        _topicFontSize = 12.f;
        _newsTitleFontSize = 14.f;
        _topicButtonWidth = 56.f;
        _topicButtonHeight = 28.f;
        _topicButtonRightGap = 6.f;
    }else if (self.view.frame.size.height == 375.f)
    {
        _topicFontSize = 13.f;
        _newsTitleFontSize = 15.f;
        _topicButtonWidth = 62.f;
        _topicButtonHeight = 31.f;
        _topicButtonRightGap = 12.f;
    }else
    {
        _topicFontSize = 14.f;
        _newsTitleFontSize = 16.f;
        _topicButtonWidth = 66.f;
        _topicButtonHeight = 33.f;
        _topicButtonRightGap = 16.f;
    }

    [self initSubViews];
}

- (void)initSubViews
{
    _buttonArrays = [[NSMutableArray alloc] init];
    NSInteger lastSelectedIndex = 0;
    CGFloat buttonGap = (self.view.frame.size.width-Topic_Button_Left_Gap-_topicButtonRightGap-4*Topic_Button_Width-30)/(4-1);
    NSArray *buttonNameArray = @[@"科技",@"娱乐",@"体育",@"头条"];
    for (int i = 0; i < 4; i++) {
        NSString *buttonTitle = buttonNameArray[i];

        
        if (i == lastSelectedIndex) {
            TWVibrantButton *button = [[TWVibrantButton alloc] initWithFrame:CGRectMake(Topic_Button_Left_Gap+(Topic_Button_Width+buttonGap)*i, Topic_Button_Top_Gap, _topicButtonWidth, _topicButtonHeight) withTitle:buttonTitle state:TodayWidgetVibrantButtonSelected];
            button.tag = i;
            button.font = [UIFont systemFontOfSize:_topicFontSize];
            button.delegate = self;
            button.hidden = NO;
            [self.view addSubview:button];
            [_buttonArrays addObject:button];
        }else
        {
            TWVibrantButton *button = [[TWVibrantButton alloc] initWithFrame:CGRectMake(Topic_Button_Left_Gap+(Topic_Button_Width+buttonGap)*i, Topic_Button_Top_Gap, _topicButtonWidth, _topicButtonHeight) withTitle:buttonTitle state:TodayWidgetVibrantButtonUnselected];
            button.tag = i;
            button.font = [UIFont systemFontOfSize:_topicFontSize];
            button.delegate = self;
            button.hidden = NO;
            [self.view addSubview:button];
            [_buttonArrays addObject:button];
        }
    }

}

#pragma mark - UIButton Action
-(void)didTWVibrantButton:(TWVibrantButton *)vibrantButton atIndex:(NSInteger)index
{
    for (int i = 0; i < _buttonArrays.count; i++) {
        TWVibrantButton *button = _buttonArrays[i];
        if (button.tag != index) {
            [button setState:TodayWidgetVibrantButtonUnselected];
        }else
        {
            [button setState:TodayWidgetVibrantButtonSelected];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsMake(0.0, 30, 0.0, 0.0);
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
