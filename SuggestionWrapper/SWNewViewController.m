//
//  SWNewViewController.m
//  SuggestionWrapper
//
//  Created by pavan on 8/1/13.
//  Copyright (c) 2013 pavan_saberjack. All rights reserved.
//

#import "SWNewViewController.h"

@interface SWNewViewController ()

@end

@implementation SWNewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 20, 50, 40)];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    [[SWAppSuggestionHandler sharedInstance] registerPageVisitWithTriggerName:@"newvisit" andPageName:@"new"];

	// Do any additional setup after loading the view.
}

- (void)buttonClicked
{
    [[SWAppSuggestionHandler sharedInstance] registerEvent:eventButtonClick forName:@"buttonOne" forPageWithName:@"new"];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
