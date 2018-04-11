//
//  ClassReuseViewController.m
//  TableViewCreateDeom
//
//  Created by developer on 2018/4/10.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "ClassReuseViewController.h"
#import "CommonTools.h"

@interface ClassReuseViewController ()
@property (nonatomic, strong)  ClassReuseView *imageDownloadView;
@property (nonatomic, strong) NSArray *downloadImagesArray;
@property (nonatomic, strong) dispatch_queue_t dispatch_queue_concurrrent;
@end

@implementation ClassReuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadImagesArray = [CommonTools getDownloadImagesArray];
    self.dispatch_queue_concurrrent = dispatch_queue_create("ASYNC_REQUEST", DISPATCH_QUEUE_CONCURRENT);
    // Do any additional setup after loading the view.
    self.imageDownloadView = [[ClassReuseView alloc] initWithFrame:self.view.frame andTableViewDelegate:self];
    [self.view addSubview:self.imageDownloadView];
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
    //注意在使用dequeueReusableCellWithIdentifier:forIndexPath时候不需要判断cell是否为空，但是如果使用旧的dequeueReusableCellWithIdentifier则需要判断cell
    //是否为nil
    ClassReuseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    //    XibReuseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //    if (cell == nil) {
    //        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //    }
    NSLog(@"---- start download cell is %@", cell);
    //update content
    [self downloadImageWithUrl:[self.downloadImagesArray objectAtIndex:indexPath.row] forTableViewCell:cell andIndex:indexPath.row];
    return cell;
}

- (void)downloadImageWithUrl:(NSString *)url forTableViewCell:(ClassReuseTableViewCell*)cell andIndex:(NSInteger)item {
    ClassReuseTableViewCell *downloadCell = cell;
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
