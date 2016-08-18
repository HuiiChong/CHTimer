//
//  CHTimer.m
//  AviationNews
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 庄春辉. All rights reserved.
//

#import "CHTimer.h"

@interface CHTimer ()
{
    dispatch_source_t timer;
}

@end

@implementation CHTimer

#pragma mark private method

- (void)scheduledTimeWithInterval__:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)yesOrNo action:(dispatch_block_t)action
{
    if(!queue){
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_resume(timer);
    /* timer精度为0.1秒 */
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        action();
        if(!yesOrNo){
            dispatch_source_cancel(timer);
        }
    });
}

#pragma mark public method

+ (CHTimer *)scheduledTimerWithInterval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)yesOrNo action:(dispatch_block_t)action
{
    if(!action){
        return nil;
    }
    CHTimer *_timer = [[CHTimer alloc] init];
    [_timer scheduledTimeWithInterval__:interval queue:queue repeats:yesOrNo action:action];
    return _timer;
}

- (void)invalidate
{
    dispatch_source_cancel(timer);
}

@end
