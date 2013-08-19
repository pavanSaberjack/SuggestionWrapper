//
//  SWAppSuggestionHandler.h
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShowPageSuggestion)(BOOL success, id result);

@class SWPageHandler;

@interface SWAppSuggestionHandler : NSObject

+ (id)sharedInstance;

- (SWPageHandler *)getPageHandlerForPageWithName:(NSString *)pageName;
- (void)registerEvent:(EventType)eventType forName:(NSString *)actorName forPageWithName:(NSString *)pageName;

/*
 -register any page for trigger for trigger name
 -register any event for trigger for a trigger name
 */
- (void)addPageToTriggerWithTriggerName:(NSString *)triggerName andPageName:(NSString *)pageName;
- (void)registerPageVisitWithTriggerName:(NSString *)triggerName andPageName:(NSString *)pageName;


- (BOOL) shouldDisplaySuggestionForTriggerName:(NSString *)triggerName;

- (void)addEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName forPageWithName:(NSString *)pageName;
- (void)registerEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName forPageWithName:(NSString *)pageName;
/*
 -set suggestion for triggers using condition
 */

// Block call which will keep waiting in the main handler of the views which will show the suggestion,
- (void) keepWaitingForTriggerWithName:(NSString *)triggerName andCallBack:(ShowPageSuggestion)callBack;
@end
