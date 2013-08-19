//
//  SWPageObject.h
//  SuggestionWrapper
//
//  Created by pavan on 8/1/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWPageObject : NSObject
@property (nonatomic, strong) NSString *pageName;
@property (nonatomic, assign) NSInteger pageVisitCount;
@property (nonatomic, assign) PagePriority priority;  // to keep in control so that one page suggestion should not be displayed twice in successtion
@end
