//
//  SWEvent.h
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWEvent : NSObject
@property (nonatomic, assign) EventType eventType;
@property (nonatomic, strong) NSString *eventActorName;
@property (nonatomic, assign) NSInteger registeredCount;
@end
