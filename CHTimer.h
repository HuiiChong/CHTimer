//
//  CHTimer.h
//  AviationNews
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 庄春辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHTimer : NSObject

+ (CHTimer *)scheduledTimerWithInterval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)yesOrNo action:(dispatch_block_t)action;

- (void)invalidate;

@end
