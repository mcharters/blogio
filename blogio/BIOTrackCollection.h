//
//  BIOTrackCollection.h
//  blogio
//
//  Created by Matt Charters on 13-01-05.
//
//

#import <Foundation/Foundation.h>

@class BIODay;

@interface BIOTrackCollection : NSObject

+ (BIOTrackCollection*)sharedInstance;

- (void)addTrack:(NSString*)track forDay:(BIODay*)day;
- (NSArray*)tracksForDay:(BIODay*)day;

@end
