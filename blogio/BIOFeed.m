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
    BIODay *day = [[BIODay weekdays] objectAtIndex:[weekdayComponents weekday]];
    
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
        NSData *itemData = [NSData dataWithContentsOfURL:itemURL];
        
        TFHpple *post = [[TFHpple alloc] initWithHTMLData:itemData];
        NSArray *elements = [post searchWithXPathQuery:@"//iframe"];
        
        for(TFHppleElement *e in elements) {
            NSString *src = [e objectForKey:@"src"];
            if([src rangeOfString:@"soundcloud"].location != NSNotFound) {
                NSLog(@"Adding track %@ on %@", src, day);
                [tracks addTrack:src forDay:day];
            }
        }
    }
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Parser error: %@", [error localizedDescription]);
}

@end
