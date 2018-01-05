//
//  QLockSlider.m

//  Created by cailianfeng on 2018/1/3.
//  Copyright © 2018年 elm. All rights reserved.
//

#import "QLockSlider.h"
#define kAnimateDuration 0.5
#define kSliderWidth self.frame.size.width
#define kSliderHeight self.frame.size.height
#define kSliderCornerRadius 4.0f
@interface QLockSlider ()
{
    UIView * _controlView;
    UILabel * _titleLable;//展示的文字
    UIView * _foregroundView;//滑块右侧的view
    UIImageView * _thumbImageView;//滑块
}

@end


@implementation QLockSlider

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor blueColor];
    _titleLable = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLable.font = [UIFont systemFontOfSize:14];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor orangeColor];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.userInteractionEnabled = YES;
    _titleLable.text = @"滑动解锁";
    
    _foregroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _foregroundView.backgroundColor = [UIColor whiteColor];
    _foregroundView.userInteractionEnabled = YES;
  
    _thumbImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _thumbImageView.backgroundColor = [UIColor grayColor];
    _thumbImageView.layer.cornerRadius = kSliderCornerRadius;
    _thumbImageView.userInteractionEnabled = YES;
    _thumbImageView.contentMode = UIViewContentModeLeft;
    
    [self addSubview:_foregroundView];
    [self addSubview:_titleLable];
    [self addSubview:_thumbImageView];
    
    self.layer.cornerRadius = kSliderCornerRadius;
    self.clipsToBounds = YES;
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setBorderWidth:0.5];

    //设置初始位置
    [self setValue:0 animated:NO];
}
#pragma mark - public method

- (void)setValue:(float)value animated:(BOOL)animated {
    if (value > 1) {
        value = 1;
    }
    if (value < 0) {
        value = 0;
    }
    CGPoint point = CGPointMake(value * kSliderWidth, 0);
    if (animated) {
        [UIView animateWithDuration:kAnimateDuration animations:^{
            [self reloadUI:point];
        } completion:^(BOOL finished) {
    
        }];
    }else{
        [self reloadUI:point];
    }
}

- (void)setForegroundCorlor:(UIColor *)foreColor backgroundColor:(UIColor *)bgColor {
    
    _foregroundView.backgroundColor = foreColor;
    self.backgroundColor = bgColor;
}

- (void)setSliderTitle:(NSString *)sliderTitle {
    _sliderTitle = sliderTitle;
    _titleLable.text = sliderTitle;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLable.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLable.textColor = titleColor;
}

- (void)setThumbWidth:(CGFloat)thumbWidth {
    _thumbWidth = thumbWidth;
    [self setValue:0 animated:NO];
}

- (void)setThumbImage:(UIImage *)thumbImage {
    _thumbImage = thumbImage;
    _thumbImageView.image = thumbImage;
    [_thumbImageView sizeToFit];
    [self setValue:0 animated:NO];
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    _thumbTintColor = thumbTintColor;
    _thumbImageView.backgroundColor = thumbTintColor;
}
#pragma mark - private method

- (void)reloadUI:(CGPoint)point {
    
    CGFloat thumbWidht = self.thumbImage ? self.thumbImage.size.width : self.thumbWidth;
    if (thumbWidht == 0) {
        thumbWidht = kSliderHeight*0.8;
    }
    point.y = 0;
    point.x -= thumbWidht/2.0;
    if (point.x > kSliderWidth-thumbWidht) {
        point.x = kSliderWidth-thumbWidht;
    }
    if (point.x < 0) {
        point.x = 0;
    }
    _thumbImageView.frame = CGRectMake(point.x, point.y, thumbWidht, kSliderHeight);
    _foregroundView.frame = CGRectMake(point.x+thumbWidht-1, point.y, kSliderWidth-point.x-thumbWidht, kSliderHeight);//+1 -1 处理圆角
    CGFloat value = _thumbImageView.frame.origin.x/(kSliderWidth-_thumbImageView.frame.size.width);
    _value = (value*100)/100;
}


#pragma mark - touchEvent

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGPoint point = [[touches anyObject] locationInView:self];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if (touch.view != _thumbImageView) {
        return;
    }
    CGPoint point = [touch locationInView:self];
    [self reloadUI:point];
    if ([self.delegate respondsToSelector:@selector(sliderValueDidChanged:)]) {
        [self.delegate sliderValueDidChanged:self];
    }
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    
    if (touch.view != _thumbImageView) {
        return;
    }
    CGPoint point = [touch locationInView:self];
    if ([self.delegate respondsToSelector:@selector(sliderValueEndChanged:)]) {
        [self.delegate sliderValueEndChanged:self];
    }
    
    if (_value == 1 && self.hiddenThumb) {
        _thumbImageView.hidden = YES;
    }
    //回到初始位置
    if (point.x < kSliderWidth-self.thumbWidth/2.0) {
        [self setValue:0 animated:YES];
    }

    
}



@end
