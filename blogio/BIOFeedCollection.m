//
//  BIOFeedCollection.m
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import "BIOFeedCollection.h"
#import "BIOFeed.h"

@interface BIOFeedCollection ()

@property (strong, nonatomic) NSMutableArray *feeds;

@end

@implementation BIOFeedCollection

- (id)init {
    self = [super init];
    if(self) {
        _feeds = [NSMutableArray array];
    }
    
    return self;
}

- (NSUInteger)countOfFeeds {
    return [self.feeds count];
}

- (void)addFeedWithURL:(NSString *)feedURL {
    BIOFeed *newFeed = [[BIOFeed alloc] initWithURL:feedURL];
    [newFeed reload];
    
    [self.feeds addObject:newFeed];
}

- (BIOFeed*)feedAtIndex:(NSUInteger)index {
    return [self.feeds objectAtIndex:index];
}

@end
