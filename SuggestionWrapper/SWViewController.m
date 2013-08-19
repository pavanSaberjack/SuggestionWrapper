//
//  SWViewController.m
//  SuggestionWrapper
//
//  Created by pavan on 7/31/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWViewController.h"
#import "SWNewViewController1.h"
#import "SWNewViewController.h"

@interface SWViewController ()<UIAlertViewDelegate>

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[SWAppSuggestionHandler sharedInstance] getPageHandlerForPageWithName:@"rootView"];
    [[SWAppSuggestionHandler sharedInstance] addPageToTriggerWithTriggerName:@"newvisit" andPageName:@"rootView"];
    
    // new 1
    [[SWAppSuggestionHandler sharedInstance] getPageHandlerForPageWithName:@"new1"];
    [[SWAppSuggestionHandler sharedInstance] addPageToTriggerWithTriggerName:@"newvisit" andPageName:@"new1"];
    
    
    
    // new
    [[SWAppSuggestionHandler sharedInstance] getPageHandlerForPageWithName:@"new"];
    [[SWAppSuggestionHandler sharedInstance] addPageToTriggerWithTriggerName:@"newvisit" andPageName:@"new"];
    
    
    [[SWAppSuggestionHandler sharedInstance] keepWaitingForTriggerWithName:@"newvisit" andCallBack:^(BOOL success, id result) {
        DLog(@"callback result %@", result);
        
        // get the page name and show it .
        // how to go the page logic u should write depending on your architecture
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:result message:@"suggestion" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        if ([result isEqualToString:@"new"]) {
            alert.tag = 111;
        }
        else if ([result isEqualToString:@"new1"])
        {
            alert.tag = 222;
        }
        [alert show];
        [alert release];
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 20, 50, 40)];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setFrame:CGRectMake(80, 20, 50, 40)];
    [button1 addTarget:self action:@selector(buttonClicked1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[SWAppSuggestionHandler sharedInstance] addEventWith:eventButtonClick forActor:@"buttonOne" ToTriggerWithTriggerName:@"clickCheck" forPageWithName:@"rootView"];
    [[SWAppSuggestionHandler sharedInstance] addEventWith:eventButtonClick forActor:@"buttontwo" ToTriggerWithTriggerName:@"clickCheck" forPageWithName:@"rootView"];
    
}

- (void)buttonClicked
{
    [[SWAppSuggestionHandler sharedInstance] registerEvent:eventButtonClick forName:@"buttonOne" forPageWithName:@"rootView"];
    
    [[SWAppSuggestionHandler sharedInstance] registerEventWith:eventButtonClick forActor:@"buttonOne" ToTriggerWithTriggerName:@"clickCheck" forPageWithName:@"rootView"];
    
    
    
    
    
    if (![[SWAppSuggestionHandler sharedInstance] shouldDisplaySuggestionForTriggerName:@"newvisit"]) {
        SWNewViewController *vc = [[SWNewViewController alloc] init];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}

- (void)buttonClicked1
{
    [[SWAppSuggestionHandler sharedInstance] registerEvent:eventButtonClick forName:@"buttontwo" forPageWithName:@"rootView"];
    [[SWAppSuggestionHandler sharedInstance] registerEventWith:eventButtonClick forActor:@"buttontwo" ToTriggerWithTriggerName:@"clickCheck" forPageWithName:@"rootView"];
    
    
    
    
    if (![[SWAppSuggestionHandler sharedInstance] shouldDisplaySuggestionForTriggerName:@"newvisit"]) {
        SWNewViewController1 *vc = [[SWNewViewController1 alloc] init];
        [vc.view setBackgroundColor:[UIColor redColor]];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 111) {
        SWNewViewController *vc = [[SWNewViewController alloc] init];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else if (alertView.tag == 222)
    {
        SWNewViewController1 *vc = [[SWNewViewController1 alloc] init];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}
@end
