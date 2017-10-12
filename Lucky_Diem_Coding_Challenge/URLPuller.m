//
//  URLPuller.m
//  Lucky_Diem_Coding_Challenge
//
//  Created by Thomas on 9/28/17.
//  Copyright © 2017 Thomas Graninger. All rights reserved.
//

#import "URLPuller.h"
#include <CommonCrypto/CommonDigest.h>

@implementation URLPuller

- (void)downloadUrlsAsync: (NSArray *)urls {
	
	//	Create a reference to the directory we want to write to
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	
	// Create a dispatch group to store async operations that are running
	dispatch_group_t group = dispatch_group_create();

	// Iterate through the collection of urls
	// There should be an edge case in the event that we have substantial amounts of data in the collection of urls.
	for (NSURL *url in urls) {
		dispatch_group_enter(group);
		
		// Request data from url
		NSURLSession *session = [NSURLSession sharedSession];
		NSURLSessionDownloadTask *task = [session downloadTaskWithURL: url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
			if (!error) {
				// Create file path {sha1 hash of url}.downloaded and write to file
				NSString *encryptedFileName = [self downloadedPathForUrl:url];
				NSData *fileData = [NSData dataWithContentsOfURL:location];
				NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", directory, encryptedFileName, @"downloaded"];
				[fileData writeToFile:filePath atomically:YES];
			}
			
			dispatch_group_leave(group);
		}];
		[task resume];
	}
	
	dispatch_group_notify(group, dispatch_get_main_queue(),^{
		NSLog(@"All Requests are completed!");
	});
}

// We could create a category for this...
- (NSString *)downloadedPathForUrl: (NSURL *)url {
	NSData *data = [NSData dataWithContentsOfURL:url];
	unsigned char digest[CC_SHA1_DIGEST_LENGTH];
	
	if (CC_SHA1([data bytes], (CC_LONG)[data length], digest)) {
		NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
		
		//	Iterate through the digest and append to our output string.
		for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
			[output appendFormat:@"%02x", digest[i]];
		}
		
		return output;
	}
	
	return nil;
}

@end
