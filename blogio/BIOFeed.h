//
//  BIOFeed.h
//  blogio
//
//  Created by Matt Charters on 12-11-25.
//
//

#import <Foundation/Foundation.h>

@interface BIOFeed : NSObject

- (id)initWithURL:(NSString*)url;
- (void)reload;

@end
