//
//  BIOTrackDownloader.m
//  blogio
//
//  Created by Matt Charters on 13-04-09.
//
//

#import "BIOTrackDownloader.h"

@implementation BIOTrackDownloader

static BIOTrackDownloader *instance = nil;

+ (BIOTrackDownloader*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)downloadTrackAtURL:(NSString *)url {
    
}

@end
