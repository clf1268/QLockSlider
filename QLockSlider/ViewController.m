//
//  ViewController.m
//  QLockSlider
//
//  Created by cailianfeng on 2018/1/5.
//  Copyright © 2018年 elm. All rights reserved.
//

#import "ViewController.h"
#import "QLockSlider.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<QLockSliderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    QLockSlider * slider4 = [[QLockSlider alloc] initWithFrame:CGRectMake(20, 150, kScreenW - 20 * 2, 50)];
    //    slider4.thumbWidth = 15;
    slider4.titleColor = [UIColor redColor];
    slider4.thumbImage = [UIImage imageNamed:@"alert_#0EC8A5"];
    slider4.hiddenThumb = YES;
    [slider4 setForegroundCorlor:[UIColor yellowColor] backgroundColor:[UIColor purpleColor]];
    slider4.delegate = self;
    [self.view addSubview:slider4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sliderValueDidChanged:(QLockSlider *)slider {
    NSLog(@"%f",slider.value);

}

- (void)sliderValueEndChanged:(QLockSlider *)slider {
    NSLog(@"----%f",slider.value);
    if (slider.value == 1) {
        NSLog(@"解锁成功");
    }
}

@end
