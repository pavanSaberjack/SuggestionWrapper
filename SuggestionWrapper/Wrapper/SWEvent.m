//
//  SWEvent.m
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWEvent.h"

@implementation SWEvent


- (id)init
{
    self = [super init];
    
    if (self) {
        self.registeredCount = 0;
        self.eventActorName = @"";
    }
    
return self;
}

@end
