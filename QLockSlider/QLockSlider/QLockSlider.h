//
//  QLockSlider.h
//
//  Created by cailianfeng on 2018/1/3.
//  Copyright © 2018年 elm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLockSlider;
@protocol QLockSliderDelegate<NSObject>
@optional
- (void)sliderValueDidChanged:(nullable QLockSlider *)slider;
- (void)sliderValueEndChanged:(nullable QLockSlider *)slider;
@end

@interface QLockSlider : UIView
@property(nullable, nonatomic, strong) UIColor *thumbTintColor;
@property(nullable, nonatomic, strong) UIImage *thumbImage;
@property(nullable, nonatomic, copy) NSString *sliderTitle;
@property(nullable, nonatomic, strong) UIFont *titleFont;
@property(nullable, nonatomic, strong) UIColor *titleColor;
@property(nonatomic, assign) CGFloat thumbWidth;
@property(nonatomic, assign) BOOL hiddenThumb;//当滑动完成 滑块是否隐藏
@property(nullable, nonatomic, weak) id<QLockSliderDelegate> delegate;
@property(nonatomic, assign, readonly) CGFloat value;

- (void)setValue:(float)value animated:(BOOL)animated;
- (void)setForegroundCorlor:(UIColor *_Nonnull)foreColor backgroundColor:(UIColor *_Nonnull)bgColor;
@end
