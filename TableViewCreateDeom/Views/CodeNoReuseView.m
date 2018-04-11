//
//  CodeNoReuseView.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "CodeNoReuseView.h"

@interface CodeNoReuseView ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id parentDelegate;
@end

@implementation CodeNoReuseView

- (instancetype)initWithFrame:(CGRect)frame andTableViewDelegate:(id)tableViewDelegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.parentDelegate = tableViewDelegate;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.tableView];
        self.tableView.delegate = self.parentDelegate;
        self.tableView.dataSource = self.parentDelegate;
    }
    return self;
}

@end
