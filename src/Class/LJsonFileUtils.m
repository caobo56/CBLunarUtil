//
//  LJsonFileUtils.m
//  CorderAlmanac
//
//  Created by caobo56 on 2017/11/22.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "LJsonFileUtils.h"

@implementation LJsonFileUtils

+(id)dataWithJsonFile:(NSString *)name{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"json"]];
    id data = [LJsonFileUtils toArrayOrNSDictionary:JSONData];
    if([data isKindOfClass:[NSString class]]){
        NSData *nsData=[data dataUsingEncoding:NSUTF8StringEncoding];
        data = [NSJSONSerialization JSONObjectWithData:nsData options:kNilOptions error:nil];
    }
    return data;
}


+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

// 将字典或者数组转化为JSON串
+ (NSData *)toJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
@end
