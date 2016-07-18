//
//  NSTimer+QCBlock.h
//  QCTimerExtension
//  version 0.0.2
//
//  Created by QC on 16/7/13.
//  Copyright © 2016年 QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (QCBlock)

/**
 *  剩余计数次数
 *  Tip:此属性仅本类目中初始化方法创建的定时器有效！
 */
@property (assign, nonatomic) NSNumber *count;

/**
 *  指定次数定时器
 *
 *  @param interval 回调时间间隔
 *  @param count 重复次数   Tip1: 如果count == NSIntegerMax 则表示无限次
 *                         Tip2: 如果count <= 0 则表示终止，否则表示具体的次数
 *  @param callback 回调Block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(void (^)(NSInteger count))callback
                                 finishback:(void (^)(void))finishback;

/**
 *  启动定时器
 */
- (void)fireTimer;

/**
 *  暂停定时器
 */
- (void)suspendTimer;

/**
 *  终止定时器
 */
- (void)stopTimer;

@end
