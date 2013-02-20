//
//  MDWScoreLevel.m
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/20.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import "MDWScoreLevel.h"

@implementation MDWScoreLevel

#define CHINESE {13,12,11,9,7} //14 1
#define ENGLISH {14,13,10,6,4} //12 3
#define MATH    {12,10,7,4,3} //10 2
#define SOCIAL  {14,13,11,9,7} //14 1
#define NATURE  {13,11,9,6,5} //14 1
#define TOTAL   {63,57,47,36,27} //64 1

- (id)init {
    self = [super init];  // Call a designated initializer here.
    if (self != nil) {
        static int chinese[5] = CHINESE;
        _chinese = chinese;
        static int english[5] = ENGLISH;
        _english = english;
        static int math[5] = MATH;
        _math = math;
        static int social[5] = SOCIAL;
        _social = social;
        static int nature[5] = NATURE;
        _nature = nature;
        static int total[5] = TOTAL;
        _total = total;
    }
    return self;
}
@end
