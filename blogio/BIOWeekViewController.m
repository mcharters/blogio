//
//  BIOFirstViewController.m
//  blogio
//
//  Created by Matt Charters on 12-05-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIOWeekViewController.h"
#import "BIOConstants.h"

@interface BIOWeekViewController ()

@end

@implementation BIOWeekViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 7 days in a week
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DayCell";
    
    UITableViewCell *dayCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (indexPath.row) {
        case Monday:
            dayCell.textLabel.text = @"Monday";
            break;
        case Tuesday:
            dayCell.textLabel.text = @"Tuesday";
            break;
        case Wednesday:
            dayCell.textLabel.text = @"Wednesday";
            break;
        case Thursday:
            dayCell.textLabel.text = @"Thursday";
            break;
        case Friday:
            dayCell.textLabel.text = @"Friday";
            break;
        case Saturday:
            dayCell.textLabel.text = @"Saturday";
            break;
        case Sunday:
            dayCell.textLabel.text = @"Sunday";
            break;
        default:
            break;
    }
    
    return dayCell;
}

@end
