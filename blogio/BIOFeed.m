//
//  BIOFeed.m
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import "BIOFeed.h"
#import "MWFeedParser.h"
#import "BIOTrackCollection.h"
#import "BIODay.h"
#import "TFHpple.h"
#import "TFHppleElement.h"

@interface BIOFeed () <MWFeedParserDelegate>

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) MWFeedParser *parser;
@property (strong, nonatomic) NSCalendar *cal;
@property (strong, nonatomic) NSMutableArray *posts;

@end

@interface BIOPost : NSObject
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) BIODay *day;

- (id)initWithURL:(NSURL*)url onDay:(BIODay*)day;
@end

@implementation BIOPost

- (id)initWithURL:(NSURL *)url onDay:(BIODay *)day {
    self = [super init];
    if(self) {
        _url = url;
        _day = [day copy];
    }
    
    return self;
}

@end

@implementation BIOFeed

- (id)initWithURL:(NSString *)url {
    self = [self init];
    if(self) {
        _url = url;
        _parser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:_url]];
        _parser.delegate = self;
        _parser.feedParseType = ParseTypeFull;
        _parser.connectionType = ConnectionTypeAsynchronously;
        
        _posts = [NSMutableArray array];
        
        _cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    return self;
}

- (void)reload {
    [self.parser parse];
}

- (void)feedParserDidStart:(MWFeedParser *)parser {
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSDateComponents *weekdayComponents = [self.cal components:NSWeekdayCalendarUnit fromDate:item.date];
    BIODay *day = [[BIODay weekdays] objectAtIndex:([weekdayComponents weekday]-1)];
    
    BIOTrackCollection *tracks = [BIOTrackCollection sharedInstance];
    
    if([item.enclosures count] > 0) {
        // we have some sort of attached file
        // find out what day this file was attached
        for (NSDictionary *enclosure in item.enclosures) {
            NSString *trackURL = [enclosure objectForKey:@"url"];
            NSLog(@"Adding track %@ on %@", trackURL, day);
            [tracks addTrack:trackURL forDay:day];
        }
    } else {
        // no enclosure, but maybe there's a stream we can grab.
        // check the entire post though, it might not be in the summary.
        NSURL *itemURL = [NSURL URLWithString:item.link];
        BIOPost *post = [[BIOPost alloc] initWithURL:itemURL onDay:day];
        
        [self.posts addObject:post];
    }
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
        
    BIOTrackCollection *tracks = [BIOTrackCollection sharedInstance];
    
    // go through the links we found and look for soundcloud stuff
    for (BIOPost *post in self.posts) {
        NSData *postData = [NSData dataWithContentsOfURL:post.url];
        
        TFHpple *postHTML = [[TFHpple alloc] initWithHTMLData:postData];
        
        NSArray *elements = [postHTML searchWithXPathQuery:@"//iframe"];
        
        for(TFHppleElement *e in elements) {
            NSString *src = [e objectForKey:@"src"];
            if(src != nil && [src rangeOfString:@"soundcloud"].location != NSNotFound) {
                NSLog(@"Adding track %@ on %@", src, post.day);
                [tracks addTrack:src forDay:post.day];
            }
        }
    }
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Parser error: %@", [error localizedDescription]);
}

@end
