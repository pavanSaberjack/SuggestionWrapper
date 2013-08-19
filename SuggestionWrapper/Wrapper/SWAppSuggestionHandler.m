//
//  SWAppSuggestionHandler.m
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWAppSuggestionHandler.h"
#import "SWTrigger.h"
#import "SWPageObject.h"
#import "SWPageHandler.h"

@interface SWAppSuggestionHandler()
@property (nonatomic, retain) NSMutableArray *pageHandlersArray; // contains array of SWPageHandler
@property (nonatomic, strong) NSMutableDictionary *triggersDictionary;
@end


@implementation SWAppSuggestionHandler
@synthesize pageHandlersArray = _pageHandlersArray;
@synthesize triggersDictionary = _triggersDictionary;

- (id)init
{
    self = [super init];

    _pageHandlersArray = [[NSMutableArray alloc] init];
    _triggersDictionary = [[NSMutableDictionary alloc] init];
    return self;
}

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    
    if (sharedInstance != nil) return sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Private methods
// It will create new page Handler if not exists already or it will create new one
- (SWPageHandler *)getPageHandlerForPageWithName:(NSString *)pageName
{
    
    //  TODO: Optimise if you can
    for (SWPageHandler *handler in _pageHandlersArray) {
        if ([handler.pageName isEqualToString:pageName]) {
            return handler;
        }
    }
    
    SWPageHandler *pageHandler = [[SWPageHandler alloc] init];
    pageHandler.pageName = pageName;
    [_pageHandlersArray addObject:pageHandler];
    
    
    return pageHandler;
}

- (void)registerEvent:(EventType)eventType forName:(NSString *)actorName forPageWithName:(NSString *)pageName
{
    for (SWPageHandler *pageHandler in _pageHandlersArray) {
        if ([pageHandler.pageName isEqualToString:pageName]) {
            [pageHandler registerEvent:eventType forName:actorName];
            break;
        }
    }
}

- (void)removeAllPageHandlers
{
    [_pageHandlersArray removeAllObjects];
}

#pragma mark - trigger methods
- (void)registerEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName forPageWithName:(NSString *)pageName
{
    for (SWPageHandler *pageHandler in _pageHandlersArray) {
        if ([pageHandler.pageName isEqualToString:pageName]) {
            [pageHandler registerEventWith:eventType forActor:actorName ToTriggerWithTriggerName:triggerName];
            break;
        }
    }
}

- (void)addEventWith:(EventType)eventType forActor:(NSString *)actorName ToTriggerWithTriggerName:(NSString *)triggerName forPageWithName:(NSString *)pageName
{
    for (SWPageHandler *pageHandler in _pageHandlersArray) {
        if ([pageHandler.pageName isEqualToString:pageName]) {
            [pageHandler addEventWith:eventType forActor:actorName ToTriggerWithTriggerName:triggerName];
            break;
        }
    }
}


- (void)addPageToTriggerWithTriggerName:(NSString *)triggerName andPageName:(NSString *)pageName
{
    if ([self.triggersDictionary valueForKey:triggerName] == nil) {
        // add trigger
        
        TriggerPageHandler *trigger = [[TriggerPageHandler alloc] init];
        trigger.visitsDifference = Low;
        
        if (pageName != nil) {
            SWPageObject *pageObject = [[SWPageObject alloc] init];
            pageObject.pageName = pageName;
            pageObject.pageVisitCount = 1;
            pageObject.priority = PagePriorityHigh;
            
            [trigger.pagesArray addObject:pageObject];
            [pageObject release];
        }
        
        
        [self.triggersDictionary setValue:trigger forKey:triggerName];
        
        return;
        
    }
    else
    {
        // check if page exists in trigger or no
        TriggerPageHandler *trigger = self.triggersDictionary[triggerName];
        
        BOOL isExists = NO;
        for (SWPageObject *pageObject in trigger.pagesArray) {
            if ([pageObject.pageName isEqualToString:pageName]) {
                // exists already
                isExists = YES;
                ++pageObject.pageVisitCount;
                break;
            }
        }
        
        if (!isExists) {
            SWPageObject *pageObject = [[SWPageObject alloc] init];
            pageObject.pageName = pageName;
            pageObject.pageVisitCount = 1;
            pageObject.priority = PagePriorityHigh;
            
            [trigger.pagesArray addObject:pageObject];
            [pageObject release];
        }

    }
    
    TriggerPageHandler *trigger = self.triggersDictionary[triggerName];
    [trigger checkForSuggestionDisplay];
    
}

- (void)registerPageVisitWithTriggerName:(NSString *)triggerName andPageName:(NSString *)pageName
{
    if ([self.triggersDictionary valueForKey:triggerName] == nil) {
        // add trigger
        
        TriggerPageHandler *trigger = [[TriggerPageHandler alloc] init];
        trigger.visitsDifference = Low;
        
        if (pageName != nil) {
            SWPageObject *pageObject = [[SWPageObject alloc] init];
            pageObject.pageName = pageName;
            pageObject.pageVisitCount = 1;
            pageObject.priority = PagePriorityHigh;
            
            [trigger.pagesArray addObject:pageObject];
            [pageObject release];
        }
        
        
        [self.triggersDictionary setValue:trigger forKey:triggerName];
        
        return;
        
    }
    else
    {
        // check if page exists in trigger or no
        TriggerPageHandler *trigger = self.triggersDictionary[triggerName];
        
        BOOL isExists = NO;
        for (SWPageObject *pageObject in trigger.pagesArray) {
            if ([pageObject.pageName isEqualToString:pageName]) {
                // exists already
                isExists = YES;
                ++pageObject.pageVisitCount;
                break;
            }
        }
        
        if (!isExists) {
            SWPageObject *pageObject = [[SWPageObject alloc] init];
            pageObject.pageName = pageName;
            pageObject.pageVisitCount = 1;
            pageObject.priority = PagePriorityHigh;
            
            [trigger.pagesArray addObject:pageObject];
            [pageObject release];
        }
        
    }
    
    TriggerPageHandler *trigger = self.triggersDictionary[triggerName];
    [trigger checkForSuggestionDisplay];
}

- (BOOL) shouldDisplaySuggestionForTriggerName:(NSString *)triggerName
{
    TriggerPageHandler *trigger = self.triggersDictionary[triggerName];
    return [trigger checkForSuggestionDisplay1];
}


- (void) keepWaitingForTriggerWithName:(NSString *)triggerName andCallBack:(ShowPageSuggestion)callBack
{
    TriggerPageHandler *trigger = self.triggersDictionary[triggerName];
    
    if (trigger) trigger.pageSuggestionCallBack = callBack;
    else DLog(@"Trigger not found");
}


- (BOOL) checkIfNeedToShowSuggestionForTriggerName:(NSString *)triggerName
{
    return NO;
}
@end
