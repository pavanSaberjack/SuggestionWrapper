//
//  SWPageHandler.h
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWActor;

@interface SWPageHandler : NSObject
@property (nonatomic, retain) NSString *pageName;

- (void)registerEvent:(EventType)eventType forName:(NSString *)actorName;

// clears count for actor, set nil if you want to clear count for all the actors else send proper actor name
- (void)clearActionCountsForActorName:(NSString *)actorName;

- (void)addEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName;
- (void)registerEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName;
@end
