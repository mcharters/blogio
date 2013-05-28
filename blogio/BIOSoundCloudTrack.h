//
//  BIOSoundCloudTrack.h
//  blogio
//
//  Created by Matt Charters on 13-05-27.
//
//

#import "BIOTrack.h"

@interface BIOSoundCloudTrack : NSObject <BIOTrack>

- (id)initWithURL:(NSString*)url;

@end
