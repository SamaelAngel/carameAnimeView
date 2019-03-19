//
//  ViewController.m
//  carameAnimeView
//
//  Created by 家里人哭成一团 on 2019/3/19.
//  Copyright © 2019 cont. All rights reserved.
//

#import "ViewController.h"
#import "carameAnimeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 100);
    [btn setTitle:@"相机" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)btnAction:(UIButton *)btn{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    carameAnimeView *c = [[carameAnimeView  alloc] initWithFrame:CGRectZero];
    [self.view.window addSubview:c];
    __weak typeof(self)weak = self;
    c.block = ^(BOOL isadd) {
        [weak presentViewController:imagePicker animated:NO completion:nil];
    };
    c.dblock = ^(BOOL isdon) {
        
    };
}

@end
