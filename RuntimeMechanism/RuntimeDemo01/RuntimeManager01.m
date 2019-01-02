//
//  RuntimeManager01.m
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/10.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import "RuntimeManager01.h"
#import "Movie.h"
@implementation RuntimeManager01
// 归档 自定义对象
- (void)archiveObject{
    
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"Movie.archiver"];//添加储存的文件名
    Movie *movie = [[Movie alloc] init];
    movie.movieId = @"11111";
    movie.movieName = @"头号玩家";
    movie.pic_url = @"http";
    
    // 开始归档
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:movie forKey:@"movie"];
    // 归档结束
    [archiver finishEncoding];
    // 将data 写入文件
    [data writeToFile:homePath atomically:YES];
}

// 解档对象
- (void)loadArchive{
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"Movie.archiver"];//添加储存的文件名

    // 开始解档
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:homePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Movie *movie = [unArchiver decodeObjectForKey:@"movie"];
    // 解档结束
    [unArchiver finishDecoding];
    
    NSString *name = movie.movieName;
    NSString *movieId = movie.movieId;
    NSString *pic = movie.pic_url;
    NSLog(@"name = %@ -- movieId = %@ -- pic = %@,",name,movieId,pic);
}
@end
