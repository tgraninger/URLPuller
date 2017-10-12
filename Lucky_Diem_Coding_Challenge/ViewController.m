//
//  ViewController.m
//  Lucky_Diem_Coding_Challenge
//
//  Created by Thomas on 9/28/17.
//  Copyright © 2017 Thomas Graninger. All rights reserved.
//

#import "ViewController.h"
#import "URLPuller.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSMutableArray *urls = [NSMutableArray new];
	int i = 0;
	
	while (i < 10) {
		NSString *urlString = [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/posts/%d", i];
		NSURL *url = [NSURL URLWithString:urlString];
		[urls addObject:url];
		i++;
	}
	
	URLPuller *puller = [URLPuller new];
	[puller downloadUrlsAsync:urls];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
