//
//  LJsonFileUtils.h
//  CorderAlmanac
//
//  Created by caobo56 on 2017/11/22.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJsonFileUtils : NSObject

/**
 将 .json文件内容，读取为 dict or Arr

 @param name name 文件名
 @return return value id对象（dict or Arr）
 */
+(id)dataWithJsonFile:(NSString *)name;

@end
