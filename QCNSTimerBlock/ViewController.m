//
//  ViewController.m
//  QCNSTimerBlock
//
//  Created by QC on 16/7/15.
//  Copyright © 2016年 QC. All rights reserved.
//

#import "NSTimer+QCBlock.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    /**
     *  错误势力
     *
     *  @param count 小于等于0时报错，无限次可将该值设为NSIntegerMax
     *
     *  @return 一个NSTimer实例
     */
    //    [NSTimer scheduledTimerWithTimeInterval:1 count:0 callback:^(NSInteger count) {
    //
    //    }
    //        finishback:^{
    //
    //        }];

    NSTimer *t1 = [NSTimer scheduledTimerWithTimeInterval:1 count:10 callback:^(NSInteger count) {
        NSLog(@"1秒重复10次定时器");
    }
        finishback:^{
            NSLog(@"1秒重复10次定时器结束");
        }];

    [NSTimer scheduledTimerWithTimeInterval:2 count:5 callback:^(NSInteger count) {
        NSLog(@"2秒重复5次定时器,count为：%ld", count);
        if (count == 4) {
            [t1 suspendTimer]; //暂停t1
            NSLog(@"暂停定时器T1");
        } else if (count == 3) {
            [t1 fireTimer]; //启动t1
            NSLog(@"启动定时器T1");
        } else if (count == 2) {
            t1.count = @3;
            NSLog(@"修改定时器T1剩余计数次数为3");
        } else if (count == 1) {
            NSLog(@"终止定时器T1，此时T1的count为：%ld", [t1.count integerValue]);
            [t1 stopTimer]; //终止t1
        }
    }
        finishback:^{
            NSLog(@"2秒重复5次定时器结束");
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
