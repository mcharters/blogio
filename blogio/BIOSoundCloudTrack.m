//
//  BIOSoundCloudTrack.m
//  blogio
//
//  Created by Matt Charters on 13-05-27.
//
//

#import "BIOSoundCloudTrack.h"

@interface BIOSoundCloudTrack () <NSURLConnectionDelegate>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *streamURL;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) NSURLConnection *soundcloudConnection;

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
                // get the full track info from the soundcloud API
                NSURL *trackURL = [NSURL URLWithString:[[pairComponents objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSString *trackID = [trackURL lastPathComponent];
                
                NSString *trackInfoURLString = [NSString stringWithFormat:@"http://api.soundcloud.com/tracks/%@.json?client_id=%@", trackID, @"a8e0793f34dc6faa42bcea7831b280d3"];
                
                // check for "secret" urls
                for(NSString *subKeyValuePair in [[trackURL query] componentsSeparatedByString:@"&"]) {
                    NSArray *subPairComponents = [subKeyValuePair componentsSeparatedByString:@"="];
                    if([[subPairComponents objectAtIndex:0] isEqualToString:@"secret_token"]) {
                        trackInfoURLString = [trackInfoURLString stringByAppendingFormat:@"&%@", subKeyValuePair];
                    }
                }
                
                NSURL *trackInfoURL = [NSURL URLWithString:trackInfoURLString];
                NSURLRequest *trackInfoRequest = [NSURLRequest requestWithURL:trackInfoURL];

                self.receivedData = [NSMutableData data];
                self.soundcloudConnection = [NSURLConnection connectionWithRequest:trackInfoRequest delegate:self];
            }
        }
    }
    
    return self;
}

- (void)play {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed.");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:self.receivedData options:0 error:nil];
    
    NSString *title;
    if(json != nil && [json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *trackInfo = (NSDictionary*)json;
        
        title = [trackInfo objectForKey:@"title"];
        self.streamURL = [trackInfo objectForKey:@"stream_url"];
    }
    
    if(title != nil) {
        self.name = title;
    } else {
        self.name = @"Sorry - track not found";
    }
    
    self.soundcloudConnection = nil;
    self.receivedData = nil;
}

@end
