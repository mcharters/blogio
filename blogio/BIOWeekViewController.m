//
//  BIOFirstViewController.m
//  blogio
//
//  Created by Matt Charters on 12-05-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIOWeekViewController.h"
#import "BIOConstants.h"
#import "BIOAddFeedViewController.h"
#import "BIOFeedCollection.h"

@interface BIOWeekViewController () <BIOAddFeedViewControllerDelegate>

@property (strong, nonatomic) BIOFeedCollection *feedCollection;

@end

@implementation BIOWeekViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedCollection = [[BIOFeedCollection alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.feedCollection = nil;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"AddFeedSegue"]) {
        BIOAddFeedViewController *addController = (BIOAddFeedViewController*)[((UINavigationController*)[segue destinationViewController]) topViewController];
        addController.delegate = self;
    }
}

- (void)addFeedControllerDidCancel:(BIOAddFeedViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addFeedControllerDidFinish:(BIOAddFeedViewController *)controller feedURL:(NSString *)feedURL {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.feedCollection addFeedWithURL:feedURL];
}

@end
