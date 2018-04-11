//
//  XibReuseTableViewCell.h
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XibReuseTableViewCell : UITableViewCell
- (void)setDownloadImage:(UIImage *)image;
- (void)setContentLabelText:(NSString *)text andNumberLabel:(NSString *)numberText;
- (void)clearContents;
@end
