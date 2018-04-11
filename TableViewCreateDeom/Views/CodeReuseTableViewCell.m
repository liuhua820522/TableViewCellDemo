//
//  CodeReuseTableViewCell.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "CodeReuseTableViewCell.h"
#import "CommonTools.h"

@interface CodeReuseTableViewCell()
@property (nonatomic, strong) UIImageView *downloadImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation CodeReuseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.downloadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, [CommonTools getTableViewCellHeight], [CommonTools getTableViewCellHeight])];
        [self addSubview:self.downloadImageView];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake([CommonTools getTableViewCellHeight] + 10, 0, self.frame.size.width - [CommonTools getTableViewCellHeight] - 20, self.frame.size.height)];
        [self addSubview:self.contentLabel];
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, 40, self.frame.size.height)];
        [self addSubview:self.numberLabel];
    }
    return self;
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
    //因为使用了复用机制，因此会触发此方法，在这个方法中可以做清空cell内容从而解决复用引起的显示错乱的问题
    [super prepareForReuse];
    [self clearContents];
}

@end
