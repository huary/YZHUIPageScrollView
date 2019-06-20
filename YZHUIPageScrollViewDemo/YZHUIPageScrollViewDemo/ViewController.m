//
//  ViewController.m
//  YZHUIPageScrollViewDemo
//
//  Created by captain on 16/12/6.
//  Copyright (c) 2016年 yzh. All rights reserved.
//

#import "ViewController.h"
#import "YZHUIPageScrollView.h"

@interface ViewController () <UIPageScrollViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) YZHUIPageScrollView *pageScrollView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self setUpChildView];
}

-(void)initData
{
    self.titleArray = @[@"美女",@"动画",@"惊悚",@"旅游",@"综艺",@"生活",@"速度激情",@"女团诱惑",@"尖叫",@"震撼现场",@"萌宠",@"畅游海外"];
}

-(void)setUpChildView
{
//    YZHUIPageScrollView *pageScrollView = [[YZHUIPageScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
    YZHUIPageScrollView *pageScrollView = [[YZHUIPageScrollView alloc] init];
//    pageScrollView.autoAdjustToCenter = NO;
    pageScrollView.scrollIndicatorLine.backgroundColor = PURPLE_COLOR.CGColor;
    [self.view addSubview:pageScrollView];
    pageScrollView.relatePageSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    pageScrollView.delegate = self;
    
    pageScrollView.titleTextAttributes = @{YZHPageTitleNormalColorKey:BLACK_COLOR,YZHPageTitleSelectedColorKey:RED_COLOR,YZHPageTitleNormalFontKey:FONT(16),YZHPageTitleSelectedFontKey:FONT(12),YZHPageTitleSelectedScaleRatioKey:@1.2, YZHPageTitleNormalBackgroundColorKey:YELLOW_COLOR};
    pageScrollView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 40);
    self.pageScrollView = pageScrollView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40 + 20, SCREEN_WIDTH, SCREEN_HEIGHT - 40 - 20)];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = GREEN_COLOR;
    scrollView.showsHorizontalScrollIndicator = NO;
    if (self.titleArray.count > 0) {
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titleArray.count , scrollView.bounds.size.height);
    }
    else
    {
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH , scrollView.bounds.size.height);
    }
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < self.titleArray.count; ++i) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.bounds.size.height)];
        subView.backgroundColor = RAND_COLOR;
    
        UILabel *label = [[UILabel alloc] init];
        label.text = self.titleArray[i];
        label.frame = CGRectMake(100, 100, 100, 40);
        [subView addSubview:label];
        
        [scrollView addSubview:subView];
    }
    self.scrollView = scrollView;
}

-(NSInteger)numberOfPagesInPageScrollView:(YZHUIPageScrollView *)pageScrollView
{
    return self.titleArray.count;
}

-(NSString*)pageScrollView:(YZHUIPageScrollView *)pageScrollView titleForRowAtIndex:(NSInteger)index
{
    NSString *name= self.titleArray[index];
    return name;
    //    return self.titleArray[index];
}

-(void)pageScrollView:(YZHUIPageScrollView *)pageScrollView didSelectedForRowAtIndex:(NSInteger)index
{
//    [self requestSubViewData:index];
    self.scrollView.delegate = nil;
    self.scrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
    self.scrollView.delegate = self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
//    CGFloat pageScrollViewContentSizeWidth = self.pageScrollView.scrollView.contentSize.width;
//    CGFloat scrollViewContentSizeWidth = scrollView.contentSize.width;
//    if (scrollViewContentSizeWidth <= 0) {
//        scrollViewContentSizeWidth = SCREEN_WIDTH;
//    }
//    CGFloat pageContentOffsetX = contentOffset.x * pageScrollViewContentSizeWidth / scrollViewContentSizeWidth;
    [self.pageScrollView setUIPageScrollViewContentOffset:contentOffset withAnimation:NO];
    //    [self.pageScrollView setUIPageScrollViewContentOffset:CGPointMake(pageContentOffsetX, 0) withPageIndex:nextPage withAnimation:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
