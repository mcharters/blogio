//
//  BIOAddFeedViewController.m
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import "BIOAddFeedViewController.h"

@interface BIOAddFeedViewController ()

@end

@implementation BIOAddFeedViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    self.feedURLTextField = nil;
    [super viewDidUnload];
}

- (IBAction)done:(id)sender {
    [[self delegate] addFeedControllerDidFinish:self feedURL:self.feedURLTextField.text];
}

- (IBAction)cancel:(id)sender {
    [[self delegate] addFeedControllerDidCancel:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.feedURLTextField) {
        [textField resignFirstResponder];
        [[self delegate] addFeedControllerDidFinish:self feedURL:self.feedURLTextField.text];
        
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
