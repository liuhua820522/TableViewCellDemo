//
//  CodeReuseTableViewCell.h
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeReuseTableViewCell : UITableViewCell
- (void)setDownloadImage:(UIImage *)image;
- (void)setContentLabelText:(NSString *)text andNumberLabel:(NSString *)numberText;
- (void)clearContents;
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;
@end
