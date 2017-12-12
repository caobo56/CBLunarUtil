//
//  ViewController.m
//  CBLunarTest
//
//  Created by caobo56 on 2017/12/6.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "ViewController.h"
#import "CBLunarUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString * str = [CBLunarUtil getChineseCalendarWithDate:dat format:@"mmdd"];
    NSLog(@"%@",str);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
