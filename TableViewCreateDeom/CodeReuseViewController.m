//
//  CodeReuseViewController.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "CodeReuseViewController.h"
#import "CodeReuseView.h"
#import "CodeReuseTableViewCell.h"
#import "CommonTools.h"

@interface CodeReuseViewController ()
@property (nonatomic, strong) CodeReuseView *reuseView;
@property (nonatomic, strong) NSArray *downloadImagesArray;
@property (nonatomic, strong) dispatch_queue_t dispatch_queue_concurrrent;
@end

@implementation CodeReuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadImagesArray = [CommonTools getDownloadImagesArray];
    self.reuseView = [[CodeReuseView alloc] initWithFrame:self.view.frame andTableViewDelegate:self];
    [self.view addSubview:self.reuseView];
    self.dispatch_queue_concurrrent = dispatch_queue_create("ASYNC_REQUEST", DISPATCH_QUEUE_CONCURRENT);
    
    // Do any additional setup after loading the view.
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
    NSString *reuseIdentifier = @"REUSE_IDENTIFIER";
    //尝试获取可以复用的tableview cell
    CodeReuseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        //第一次创建的时候会单独创建n个cell，但是因为使用了复用机制，因此如果超出屏幕，滚动时会发现取出来的是当前滚出屏幕的那个cell，比如第一个滚出屏幕，之前满屏最底部没有显示的cell显示出来，
        //此时打印cell地址会发现用的就恰恰是滚出屏幕的第一个cell的。依次类推。倒数第二个会使用正数第二个cell的内存地址
        cell = [[CodeReuseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        NSLog(@"---- start create cell is %@", cell);
    }
    NSLog(@"---- start download cell is %@", cell);
    
    //update content
    [self downloadImageWithUrl:[self.downloadImagesArray objectAtIndex:indexPath.row] forTableViewCell:cell andIndex:indexPath.row];
    return cell;
}

- (void)downloadImageWithUrl:(NSString *)url forTableViewCell:(CodeReuseTableViewCell*)cell andIndex:(NSInteger)item {
    CodeReuseTableViewCell *downloadCell = cell;
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
