//
//  BIOFeed.m
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import "BIOFeed.h"

@interface BIOFeed ()

@property (strong, nonatomic) NSString *url;

@end

@implementation BIOFeed

- (id)initWithURL:(NSString *)url {
    self = [self init];
    if(self) {
        _url = url;
    }
    
    return self;
}

@end
