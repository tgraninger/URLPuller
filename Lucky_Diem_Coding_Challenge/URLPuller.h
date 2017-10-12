//
//  URLPuller.h
//  Lucky_Diem_Coding_Challenge
//
//  Created by Thomas on 9/28/17.
//  Copyright © 2017 Thomas Graninger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLPuller : NSObject

- (void)downloadUrlsAsync: (NSArray *)urls;

@end
