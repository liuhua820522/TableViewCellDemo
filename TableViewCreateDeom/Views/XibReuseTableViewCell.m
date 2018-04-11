//
//  XibReuseTableViewCell.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "XibReuseTableViewCell.h"
@interface XibReuseTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *downloadImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end

@implementation XibReuseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDownloadImage:(UIImage *)image {
    [self.downloadImageView setImage:image];
}

- (void)setContentLabelText:(NSString *)text andNumberLabel:(NSString *)numberText {
    self.contentLabel.text = text;
    self.numberLabel.text = numberText;
}

- (void)clearContents {
    [self.downloadImageView setImage:NULL];
    [self.contentLabel setText:@""];
    [self.numberLabel setText:@""];
}

- (void)prepareForReuse {
    //使用了复用，因此可以在此处做清空cell内容的操作
    [super prepareForReuse];
    [self clearContents];
}

@end
