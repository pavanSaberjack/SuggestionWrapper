//
//  SWPageHandler.m
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWPageHandler.h"
#import "SWEvent.h"
#import "SWTrigger.h"

@interface SWPageHandler()
@property (nonatomic, strong) NSMutableArray *actorsArray;
@property (nonatomic, strong) NSMutableDictionary *actionsDictionary; // this is for local, we can replace this with any storage like sqlite or coredata
@property (nonatomic, strong) NSMutableDictionary *triggersDictionary;
@end


@implementation SWPageHandler
@synthesize actorsArray = _actorsArray;

- (void)dealloc
{
    self.actorsArray = nil;
    self.actionsDictionary = nil;
    self.triggersDictionary = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

#pragma mark - private methods
- (void)initialize
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.actorsArray = array;
    [array release];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    self.actionsDictionary = dictionary;
    [dictionary release];
    
    NSMutableDictionary *triggerDict = [[NSMutableDictionary alloc] init];
    self.triggersDictionary = triggerDict;
    [triggerDict release];
}

- (void)registerEvent:(EventType)eventType forName:(NSString *)actorName
{
    DLog(@"event registered for actor : %@ for page :%@", actorName, self.pageName);
    
    if (![self.actorsArray containsObject:actorName]) {
        [self.actorsArray addObject:actorName];
    }
    
    // increment the count occurance of event
    if (![self.actionsDictionary valueForKey:actorName]) {
        [self.actionsDictionary setValue:[NSNumber numberWithInteger:0] forKey:actorName];
    }
    else
    {
        NSInteger count = [[self.actionsDictionary valueForKey:actorName] integerValue];
        [self.actionsDictionary setValue:[NSNumber numberWithInteger:++count] forKey:actorName];
    }
}

- (void)clearActionCountsForActorName:(NSString *)actorName
{
    if (actorName == nil) {
        for (NSString *key in self.actionsDictionary) {
            [self.actionsDictionary setValue:[NSNumber numberWithInteger:0] forKey:key];
        }
    }
    else
    {
        // is valid actor name
        if ([self.actionsDictionary valueForKey:actorName]) {
            [self.actionsDictionary setValue:[NSNumber numberWithInteger:0] forKey:actorName];
        }
    }
}

- (NSArray *) getAllActorsName
{
    return [self.actorsArray count] > 0? [NSArray arrayWithArray:self.actorsArray]: nil;
}

#pragma mark - trigger methods
- (void)addEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName
{
    // Search if a trigger already exists
    // else add new trigger
    
    if (![self checkIfTriggerAlreadyExistsWithEventType:eventType forActor:actorName ToTriggerWithTriggerName:triggerName]) {
        
        SWEvent *event = [[SWEvent alloc] init];
        event.eventType = eventType;
        event.registeredCount = 0;
        event.eventActorName = actorName;
        
        if ([self.triggersDictionary valueForKey:triggerName] == nil) {
            TriggerEventsHandler *trigger = [[TriggerEventsHandler alloc] init];
            trigger.triggerType = triggerTypeEventHandler;
            trigger.triggerName = triggerName;
            trigger.parentPageName = self.pageName;
            
            [trigger.eventsArray addObject:event];
            
            [self.triggersDictionary setObject:trigger forKey:triggerName];
            
            [trigger release];
        }
        else
        {
            TriggerEventsHandler *trigger = [self.triggersDictionary valueForKey:triggerName];
            [trigger.eventsArray addObject:event];
        }
        
        [event release];
    }
}


- (void)registerEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName
{
    
    TriggerEventsHandler *trigger = self.triggersDictionary[triggerName];
    
    for (SWEvent *event in trigger.eventsArray) {
        if ([event.eventActorName isEqualToString:actorName] && event.eventType == eventType) {
            ++event.registeredCount;
            break;
        }
    }
    
    
    // add a condition
    BOOL show = NO;
    
    if ([trigger.eventsArray count] > 1) {
        for (SWEvent *event in trigger.eventsArray) {
            if (event.registeredCount == 0) {
                if (show) {
                    show = NO;
                    break;
                }
                show = YES;
            }
        }
    }
    
    
    if (show) {
        DLog(@"trigger man ");
    }
}

- (BOOL) checkIfTriggerAlreadyExistsWithEventType:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName
{
    // if no trigger exists with the name
    if ([self.triggersDictionary valueForKey:triggerName] == nil) {
        return FALSE;
    }
    
    // search for events in trigger array
    TriggerEventsHandler *trigger = self.triggersDictionary[triggerName];
    
    for (SWEvent *event in trigger.eventsArray) {
        if ([event.eventActorName isEqualToString:actorName] && event.eventType == eventType) {
            return TRUE;
        }
    }
    
    return FALSE;
}
@end
