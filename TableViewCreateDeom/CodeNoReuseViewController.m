//
//  CodeNoReuseViewController.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "CodeNoReuseViewController.h"

@interface CodeNoReuseViewController ()
@property (nonatomic, strong) CodeNoReuseView *noReuseView;
@property (nonatomic, strong) NSArray *downloadImagesArray;
@property (nonatomic, strong) dispatch_queue_t dispatch_queue_concurrrent;

@end

@implementation CodeNoReuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadImagesArray = [CommonTools getDownloadImagesArray];
    // Do any additional setup after loading the view.
    self.noReuseView = [[CodeNoReuseView alloc] initWithFrame:self.view.frame andTableViewDelegate:self];
    [self.view addSubview:self.noReuseView];
    self.dispatch_queue_concurrrent = dispatch_queue_create("ASYNC_REQUEST", DISPATCH_QUEUE_CONCURRENT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.height / 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.downloadImagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath每次创建不一样的cell
    CodeNoReuseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"---- the indexpath is %@", indexPath);
    
    if (cell == nil) {
        //第一次创建的时候会单独创建n个cell，但是因为此处没有使用复用机制，因此当滚动屏幕时，会发现每次只要有cell移除屏幕就会被释放掉，出现在屏幕中的新的cell会同时创建一个全新的，而不会从复用池中尝试获取可以复用的cell单元
        cell = [[CodeNoReuseTableViewCell alloc] init];
        NSLog(@"---- start create cell is %@", cell);
    }
    NSLog(@"---- start download cell is %@", cell);
    //update content
    [self downloadImageWithUrl:[self.downloadImagesArray objectAtIndex:indexPath.row] forTableViewCell:cell andIndex:indexPath.row];
    return cell;
}

- (void)downloadImageWithUrl:(NSString *)url forTableViewCell:(CodeNoReuseTableViewCell*)cell andIndex:(NSInteger)item {
    CodeNoReuseTableViewCell *downloadCell = cell;
    NSInteger index = item;
    NSString *downloadImageUrl = url;
    dispatch_async(self.dispatch_queue_concurrrent, ^{
        //start download
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:downloadImageUrl]];
        //data -> image
        UIImage *image = [UIImage imageWithData:imageData];
        //main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            //This application is modifying the autolayout engine from a background thread after the engine was accessed from the main thread.
            //需要注意ui的刷新只能在主线程中，否则报以上的warning
            NSLog(@"---- finish download cell is %p", &downloadCell);
            [downloadCell setDownloadImage:image];
            [downloadCell setContentLabelText:downloadImageUrl andNumberLabel:[NSString stringWithFormat:@"%ld", index]];
        });
    });
}
@end
