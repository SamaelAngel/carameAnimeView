# carameAnimeView
完美实现相机光圈打开关闭动画,仿CameraIrisHollowOpen
不改变系统转场 可直接使用
 carameAnimeView *c = [[carameAnimeView  alloc] initWithFrame:CGRectZero];
    [self.view.window addSubview:c];
    __weak typeof(self)weak = self;
    c.block = ^(BOOL isadd) {
        [weak presentViewController:imagePicker animated:NO completion:nil];
    };
    c.dblock = ^(BOOL isdon) {
        
    };
![image](https://raw.githubusercontent.com/SamaelAngel/carameAnimeView/master/C338F9E0-4B34-4E0F-A111-50B6837B8374.gif)
