//
//  SWEnumHandler.h
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#ifndef SuggestionWrapper_SWEnumHandler_h
#define SuggestionWrapper_SWEnumHandler_h



#endif


typedef NS_ENUM(NSInteger, ActionType)
{
    actionType
};

typedef NS_ENUM(NSInteger, EventType)
{
    eventButtonClick = 0
};

typedef NS_ENUM(NSInteger, TriggerType)
{
    triggerTypeEventHandler = 0,
    triggerTypePageHandler
};

typedef NS_ENUM(NSInteger, ConditionType)
;

typedef NS_ENUM(NSInteger, PagePriority)
{
    PagePriorityLow = 0,
    PagePriorityMedium,
    PagePriorityHigh,
    PagePriorityDisabled
};

typedef NS_ENUM (NSInteger, VisitsDifference)
{
    Low = 10,
    Medium = 15,
    High =20
};