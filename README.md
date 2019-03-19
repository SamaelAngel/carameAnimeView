# carameAnimeView
项目需要,于是就自己做了一个(其实是因为懒惰的本人并没有找到轮子,网上只有一个安卓版的正六边形光圈)
没有swift版本,实在是懒得写了,思路都在代码里,其实做起来很简单,需要swift版本的的宝宝们自己写吧.


完美实现相机光圈打开关闭动画,仿CameraIrisHollowOpen
不改变系统转场 可直接使用

    carameAnimeView *c = [[carameAnimeView  alloc] initWithFrame:CGRectZero];
    [self.view.window addSubview:c];
    __weak typeof(self)weak = self;
    c.block = ^(BOOL isadd) {
        [weak presentViewController:imagePicker animated:NO completion:nil];//中间block 在这里push,present
    };
    c.dblock = ^(BOOL isdon) {//结束block
    };
    
![image](https://raw.githubusercontent.com/SamaelAngel/carameAnimeView/master/C338F9E0-4B34-4E0F-A111-50B6837B8374.gif)

