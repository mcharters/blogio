//
//  BIODay.m
//  blogio
//
//  Created by Matt Charters on 13-01-05.
//
//

#import "BIODay.h"

static BIODay *sunday;
static BIODay *monday;
static BIODay *tuesday;
static BIODay *wednesday;
static BIODay *thursday;
static BIODay *friday;
static BIODay *saturday;

static NSArray *weekdays;

@interface BIODay ()

+ (BIODay*)dayWithWeekday:(NSInteger)weekday;
@property NSInteger weekday;

@end

@implementation BIODay

+ (BIODay*)dayWithWeekday:(NSInteger)weekday {
    BIODay *day = [[BIODay alloc] init];
    day.weekday = weekday;
    
    return day;
}

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized) {
        initialized = YES;

        sunday = [BIODay dayWithWeekday:0];
        monday = [BIODay dayWithWeekday:1];
        tuesday = [BIODay dayWithWeekday:2];
        wednesday = [BIODay dayWithWeekday:3];
        thursday = [BIODay dayWithWeekday:4];
        friday = [BIODay dayWithWeekday:5];
        saturday = [BIODay dayWithWeekday:6];
        
        weekdays = [NSArray arrayWithObjects:sunday, monday, tuesday, wednesday, thursday, friday, saturday, nil];
    }
}

+ (NSArray*)weekdays {
    return weekdays;
}

+ (BIODay*)sunday { return sunday; }
+ (BIODay*)monday { return monday; }
+ (BIODay*)tuesday { return tuesday; }
+ (BIODay*)wednesday { return wednesday; }
+ (BIODay*)thursday { return thursday; }
+ (BIODay*)friday { return friday; }
+ (BIODay*)saturday { return saturday; }


- (NSString*)description {
    switch(self.weekday) {
        case 0:
            return @"Sunday";
        case 1:
            return @"Monday";
        case 2:
            return @"Tuesday";
        case 3:
            return @"Wednesday";
        case 4:
            return @"Thursday";
        case 5:
            return @"Friday";
        case 6:
            return @"Saturday";
        default:
            return [super description];
    }
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[BIODay class]]) {
        return self.weekday == ((BIODay*)object).weekday;
    }
    
    return NO;
}

- (id)copyWithZone:(NSZone *)zone {
    return [BIODay dayWithWeekday:self.weekday];
}

@end