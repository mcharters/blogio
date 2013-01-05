//
//  BIODay.h
//  blogio
//
//  Created by Matt Charters on 13-01-05.
//
//

#import <Foundation/Foundation.h>

@interface BIODay : NSObject <NSCopying>

+ (NSArray*)weekdays;

+ (BIODay *)sunday;
+ (BIODay *)monday;
+ (BIODay *)tuesday;
+ (BIODay *)wednesday;
+ (BIODay *)thursday;
+ (BIODay *)friday;
+ (BIODay *)saturday;

@end