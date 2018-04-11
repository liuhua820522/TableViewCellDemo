//
//  CommonTools.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools
+ (NSArray *)getDownloadImagesArray {
    return  [NSArray arrayWithObjects:@"http://scimg.jb51.net/allimg/160825/103-160R5131F40-L.jpg", @"http://img.sc115.com/uploads/sc/cjpgs/1508/apic13917_sc115.com.jpg", @"http://img34.photophoto.cn/20150316/0034034871710625_s.jpg",@"http://scimg.jb51.net/allimg/120803/2-120P31030450-L.jpg",@"http://img30.photophoto.cn/20140209/0005018443228711_s.jpg", @"http://img.duoziwang.com/2017/09/152202455681.jpg", @"http://img.duoziwang.com/2017/03/02/B3460.jpg", @"http://img.duoziwang.com/2017/09/152159465064.jpg", @"http://img.duoziwang.com/2018/03/232215266625.jpg",@"http://img1.touxiang.cn/uploads/20121225/25-063924_836.jpg", @"http://file03.16sucai.com/2017/240/16sucai_v567c086_4ae.JPG", @"http://imgtu.5011.net/uploads/content/20170314/1240971489483319.jpg", nil];
}

+ (CGFloat)getTableViewCellHeight {
    return [[UIScreen mainScreen] bounds].size.height / 6;
}
@end
