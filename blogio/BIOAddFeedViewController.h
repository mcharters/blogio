//
//  BIOAddFeedViewController.h
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import <UIKit/UIKit.h>

@protocol BIOAddFeedViewControllerDelegate;

@interface BIOAddFeedViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id<BIOAddFeedViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *feedURLTextField;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@protocol BIOAddFeedViewControllerDelegate <NSObject>

- (void)addFeedControllerDidCancel:(BIOAddFeedViewController*)controller;
- (void)addFeedControllerDidFinish:(BIOAddFeedViewController*)controller feedURL:(NSString*)feedURL;

@end