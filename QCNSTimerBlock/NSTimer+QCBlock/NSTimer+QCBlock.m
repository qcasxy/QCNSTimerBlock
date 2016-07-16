//
//  NSTimer+QCBlock.m
//  QCTimerExtension
//
//  Created by QC on 16/7/13.
//  Copyright © 2016年 QC. All rights reserved.
//

#import "NSTimer+QCBlock.h"
#import <objc/runtime.h>

@interface NSTimer ()

@end

@implementation NSTimer (QCBlock)

- (NSNumber *)count {
    return objc_getAssociatedObject(self, @selector(count));
}

- (void)setCount:(NSNumber *)count {
    objc_setAssociatedObject(self, @selector(count), count, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(void (^)(NSInteger))callback
                                 finishback:(void (^)(void))finishback {
    NSAssert(count > 0, @"The value of the parameter ‘count’ cannot be less than 0! If you want to represent unlimited, you can set the value of ‘count’ is ‘NSIntegerMax’.");

    NSDictionary *dic = @{ @"callback" : [callback copy],
                           @"finishback" : [finishback copy] };

    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:interval
                                                  target:self
                                                selector:@selector(onTimerUpdateCountBlock:)
                                                userInfo:dic
                                                 repeats:YES];
    t.count = @(count);
    return t;
}

+ (void)onTimerUpdateCountBlock:(NSTimer *)timer {
    void (^callback)(NSInteger) = timer.userInfo[@"callback"];
    timer.count = @([timer.count integerValue] - 1);
    if (callback) {
        callback([timer.count integerValue]);
    }

    if ([timer.count integerValue] == 0) {
        void (^finishback)(void) = timer.userInfo[@"finishback"];
        [timer stopTimer];
        if (finishback) {
            finishback();
        }
    }
}

- (void)fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)suspendTimer {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer {
    if (self.isValid) {
        [self invalidate];
    }
}

@end
