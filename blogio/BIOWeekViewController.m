//
//  BIOFirstViewController.m
//  blogio
//
//  Created by Matt Charters on 12-05-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIOWeekViewController.h"
#import "BIODay.h"
#import "BIOAddFeedViewController.h"
#import "BIOFeedCollection.h"
#import "BIODayViewController.h"

@interface BIOWeekViewController () <BIOAddFeedViewControllerDelegate>

@property (strong, nonatomic) BIOFeedCollection *feedCollection;

@end

@implementation BIOWeekViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedCollection = [[BIOFeedCollection alloc] init];
    
    // for debug, add feed right away
    [self.feedCollection addFeedWithURL:@"http://feeds.feedburner.com/GVSB"];
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
    return [[BIODay weekdays] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DayCell";
    
    UITableViewCell *dayCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    dayCell.textLabel.text = [NSString stringWithFormat:@"%@", [[BIODay weekdays] objectAtIndex:indexPath.row]];
    
    return dayCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"AddFeedSegue"]) {
        BIOAddFeedViewController *addController = (BIOAddFeedViewController*)[((UINavigationController*)[segue destinationViewController]) topViewController];
        addController.delegate = self;
    } else if([segue.identifier isEqualToString:@"ViewDaySegue"]) {
        BIODayViewController *dayController = ((BIODayViewController*)[segue destinationViewController]);
        BIODay *selectedDay = [[BIODay weekdays] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        dayController.day = selectedDay;
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
