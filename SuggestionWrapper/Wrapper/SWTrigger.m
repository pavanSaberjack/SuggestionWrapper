//
//  SWTrigger.m
//  SuggestionWrapper
//
//  Created by pavan on 8/1/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWTrigger.h"
#import "SWPageObject.h"


@implementation SWTrigger
@synthesize visitsDifference = _visitsDifference;

- (id)init
{
    self = [super init];
    
    if (self) {
        self.triggerName = @"";
    }
    
    return self;
}

- (void)setVisitsDifference:(VisitsDifference)visitsDifference
{
    _visitsDifference = visitsDifference;
    
}

@end






@implementation TriggerPageHandler

- (void)dealloc
{
    self.pagesArray = nil;
    
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.pagesArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)checkForSuggestionDisplay
{
    
    // back up incase
    if ([self.pagesArray count] == 0) {
        return;
    }
    
    
    NSInteger bufferCount = self.visitsDifference;
    
    // get all the pages where pages state is not disables
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"priority != %d", PagePriorityDisabled]];
    NSArray *filteredArray = [self.pagesArray filteredArrayUsingPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pageVisitCount" ascending:YES];
    NSArray *sortedArray = [filteredArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    if ([sortedArray count] > 1) {
        SWPageObject *firstObject = sortedArray[0];
        SWPageObject *lastObject = [sortedArray lastObject];
        
        
        if ((lastObject.pageVisitCount - firstObject.pageVisitCount) >=  3) {
            
            // set priority to disable
            firstObject.priority = PagePriorityDisabled;
            DLog(@"%d", (lastObject.pageVisitCount - firstObject.pageVisitCount));
            
            self.pageSuggestionCallBack(TRUE, firstObject.pageName);
            
            return;
        }
    }

    
    // if only one page is remaining in the list which is not disabled then make it as disabled only
    if ([sortedArray count] == 1) {
        SWPageObject *firstObject = sortedArray[0];
        firstObject.priority = PagePriorityDisabled;
    }
        
//    // Implement least visited priority most algo here
//    
//    for (SWPageObject *page in self.pagesArray) {
//        if (page.priority != PagePriorityDisabled) {
//            if ([self checkIfPageHasLeastVisitsForPage:page]) {
//                self.pageSuggestionCallBack(TRUE, @"gotcha");
//                break;
//            } 
//        }
//    }
//    
//    
//    [self checkIfAllPagesAreDisabled];
    
}


- (BOOL)checkForSuggestionDisplay1
{
    
    // back up incase
    if ([self.pagesArray count] == 0) {
        return NO;
    }
    
    
    NSInteger bufferCount = self.visitsDifference;
    
    // get all the pages where pages state is not disables
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"priority != %d", PagePriorityDisabled]];
    NSArray *filteredArray = [self.pagesArray filteredArrayUsingPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pageVisitCount" ascending:YES];
    NSArray *sortedArray = [filteredArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    if ([sortedArray count] > 1) {
        SWPageObject *firstObject = sortedArray[0];
        SWPageObject *lastObject = [sortedArray lastObject];
        
        if ((lastObject.pageVisitCount - firstObject.pageVisitCount) >=  3) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)checkIfPageHasLeastVisitsForPage:(SWPageObject *)pageObj
{
    // back up incase
    if ([self.pagesArray count] == 0) {
        return NO;
    }
    
    
    NSInteger bufferCount = self.visitsDifference;
    
    // get all the pages where pages state is not disables
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"priority != %d", PagePriorityDisabled]];
    NSArray *filteredArray = [self.pagesArray filteredArrayUsingPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pageVisitCount" ascending:YES];
    NSArray *sortedArray = [filteredArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    if ([sortedArray count] > 1) {
        SWPageObject *firstObject = sortedArray[0];
        SWPageObject *lastObject = [sortedArray lastObject];
        
        
        if ((lastObject.pageVisitCount - firstObject.pageVisitCount) >=  bufferCount) {
            
            // set priority to disable
            firstObject.priority = PagePriorityDisabled;
            DLog(@"%d", (lastObject.pageVisitCount - firstObject.pageVisitCount));
            return YES;
            
        }
        
        
    }
    
    
    
    
    //==============================================
    /*
    for (SWPageObject *page in self.pagesArray) {
        if (page != pageObj) {
            // first time suggestion
            
            if (page.priority != PagePriorityDisabled) {
                if ((page.pageVisitCount - pageObj.pageVisitCount) >=  bufferCount) {
                    
                    // set priority to disable
                    pageObj.priority = PagePriorityDisabled;
                    DLog(@"%d", (page.pageVisitCount - pageObj.pageVisitCount));
                    return YES;
                    
                }
            }
        }
    }
     
    */ 
    // =================================================
    return NO;
}

- (void)checkIfAllPagesAreDisabled
{
    BOOL isExists = NO;
    
    for (SWPageObject *page in self.pagesArray) {
        if (page.priority != PagePriorityDisabled) {
            isExists = YES;
        }
    }
    
    if (!isExists) {
        for (SWPageObject *page in self.pagesArray) {
            page.priority = PagePriorityHigh;
        }
    }
}


@end


@implementation TriggerEventsHandler
- (void)dealloc
{
    self.eventsArray = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.parentPageName = @"";
        self.eventsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end