//
//  BIOFeedCollection.h
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import <Foundation/Foundation.h>

@class BIOFeed;

@interface BIOFeedCollection : NSObject

- (NSUInteger)countOfFeeds;
- (void)addFeedWithURL:(NSString*)feedURL;
- (BIOFeed*)feedAtIndex:(NSUInteger)index;

@end
