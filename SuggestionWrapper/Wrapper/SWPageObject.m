//
//  SWPageObject.m
//  SuggestionWrapper
//
//  Created by pavan on 8/1/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWPageObject.h"

@implementation SWPageObject
- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.pageName = @"";
        self.pageVisitCount = 0;
    }
    
    return self;
}
@end
