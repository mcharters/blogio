//
//  BIOSecondViewController.m
//  blogio
//
//  Created by Matt Charters on 12-05-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIOFeedViewController.h"

@interface BIOFeedViewController ()

@end

@implementation BIOFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
