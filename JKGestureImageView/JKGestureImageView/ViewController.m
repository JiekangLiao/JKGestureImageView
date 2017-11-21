//
//  ViewController.m
//  JKGestureImageView
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 JackLiao. All rights reserved.
//

#import "ViewController.h"
#import "JKGestureImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JKGestureImageView *jkGestureImageView = [[JKGestureImageView alloc]initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width-30*2, 200)];
    jkGestureImageView.contentMode = UIViewContentModeScaleToFill;
    jkGestureImageView.image = [UIImage imageNamed:@"meinv.png"];
    [self.view addSubview:jkGestureImageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
