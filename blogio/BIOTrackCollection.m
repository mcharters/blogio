//
//  BIOTrackCollection.m
//  blogio
//
//  Created by Matt Charters on 13-01-05.
//
//

#import "BIOTrackCollection.h"
#import "BIODay.h"

static BIOTrackCollection *sharedInstance;

@interface BIOTrackCollection ()

@property (strong, nonatomic) NSMutableDictionary *days;

@end

@implementation BIOTrackCollection

+ (BIOTrackCollection*)sharedInstance {
    return sharedInstance;
}

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized) {
        initialized = YES;
        
        sharedInstance = [[BIOTrackCollection alloc] init];
        sharedInstance.days = [NSMutableDictionary dictionaryWithCapacity:[[BIODay weekdays] count]];
    }
}

- (void)addTrack:(id<BIOTrack>)track forDay:(BIODay *)day {
    NSMutableArray *tracksForDay = [self.days objectForKey:day];
    if(tracksForDay == nil) {
        tracksForDay = [NSMutableArray arrayWithObject:track];
        [self.days setObject:tracksForDay forKey:day];
    } else {
        [tracksForDay addObject:track];
    }
}

- (NSArray*)tracksForDay:(BIODay *)day {
    return [self.days objectForKey:day];
}

@end
