//
//  BIOFeed.m
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import "BIOFeed.h"
#import "MWFeedParser.h"

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
    NSLog(@"Parser started");
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Got info: %@", [info description]);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Got item: %@", [item description]);
    
    
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Parser finished");
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Parser error: %@", [error localizedDescription]);
}

@end
