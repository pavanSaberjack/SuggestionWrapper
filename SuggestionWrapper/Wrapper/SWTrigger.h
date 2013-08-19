//
//  SWTrigger.h
//  SuggestionWrapper
//
//  Created by pavan on 8/1/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//




#import <Foundation/Foundation.h>

@class SWEvent;
@class SWPageObject;
@class SWAppSuggestionHandler;



typedef id(^ShowEventSuggestion)(NSString *pageName, NSString *triggerName);

@interface SWTrigger : NSObject
@property (nonatomic, strong) NSString *triggerName;
@property (nonatomic, assign) TriggerType triggerType; // differentiate between page and events
@property (nonatomic, assign) VisitsDifference visitsDifference;
@end


@interface TriggerPageHandler : SWTrigger
@property (nonatomic, strong) NSMutableArray *pagesArray;
@property (nonatomic, copy) ShowPageSuggestion pageSuggestionCallBack;

- (void)checkForSuggestionDisplay;
- (BOOL)checkForSuggestionDisplay1;
@end


@interface TriggerEventsHandler : SWTrigger
@property (nonatomic, strong) NSString *parentPageName;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@end