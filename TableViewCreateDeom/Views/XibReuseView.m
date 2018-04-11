//
//  XibReuseView.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "XibReuseView.h"
#import "XibReuseTableViewCell.h"

@interface XibReuseView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XibReuseView

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"XibReuseView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.tableView.delegate = delegate;
        self.tableView.dataSource = delegate;
        [self.tableView registerNib:[UINib nibWithNibName:@"XibReuseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"REUSE_IDENTIFIER"];
    }
    return self;
}

@end
