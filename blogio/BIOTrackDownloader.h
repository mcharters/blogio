//
//  BIOTrackDownloader.h
//  blogio
//
//  Created by Matt Charters on 13-04-09.
//
//

#import <Foundation/Foundation.h>

@interface BIOTrackDownloader : NSObject

+ (BIOTrackDownloader*)sharedInstance;

- (void)downloadTrackAtURL:(NSString*)url;

@end
