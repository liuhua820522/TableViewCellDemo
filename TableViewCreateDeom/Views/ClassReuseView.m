//
//  ClassReuseView.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "ClassReuseView.h"
#import "ClassReuseTableViewCell.h"

@interface ClassReuseView ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ClassReuseView
- (instancetype)initWithFrame:(CGRect)frame andTableViewDelegate:(id)tableViewDelegate {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ClassReuseView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.tableView.delegate = tableViewDelegate;
        self.tableView.dataSource = tableViewDelegate;
        [self.tableView registerClass:[ClassReuseTableViewCell class] forCellReuseIdentifier:@"REUSE_IDENTIFIER"];
    }
    return self;
}

@end
