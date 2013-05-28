//
//  BIOSoundCloudTrack.m
//  blogio
//
//  Created by Matt Charters on 13-05-27.
//
//

#import "BIOSoundCloudTrack.h"

@interface BIOSoundCloudTrack ()

@property (strong, nonatomic) NSString *name;

@end

@implementation BIOSoundCloudTrack

- (id)initWithURL:(NSString *)url {
    self = [super init];
    if(self != nil) {
        NSURL *urlObject = [[NSURL alloc] initWithString:url];
        NSArray *urlParams = [[urlObject query] componentsSeparatedByString:@"&"];
        
        for(NSString *keyValuePair in urlParams) {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            if([[pairComponents objectAtIndex:0] isEqualToString:@"url"]) {
                _name = [[pairComponents objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        }
    }
    
    return self;
}

- (void)play {
    
}

@end
