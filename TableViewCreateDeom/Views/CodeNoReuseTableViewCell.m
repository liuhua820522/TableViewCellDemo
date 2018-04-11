//
//  CodeNoReuseTableViewCell.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "CodeNoReuseTableViewCell.h"
#import "CommonTools.h"

@interface CodeNoReuseTableViewCell()
@property (nonatomic, strong) UIImageView *downloadImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation CodeNoReuseTableViewCell

- (instancetype)init {
    self = [super init];
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
    //因为没有使用复用的机制，因此此处的方法不会被调用到
    [super prepareForReuse];
    [self clearContents];
}

@end
