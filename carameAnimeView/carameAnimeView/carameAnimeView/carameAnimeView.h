//
//  carameAnimeView.h
//  Photographing
//
//  Created by 家里人哭成一团 on 2019/3/18.
//  Copyright © 2019 xialei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^addBlock)(BOOL isadd);
typedef void(^donBlock)(BOOL isdon);

@interface carameAnimeView : UIView
{
    CGFloat scale;
    NSArray *paths;
    NSArray *points;
    NSArray *layers;
}
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, copy) addBlock block;//中间黑屏时调用
@property (nonatomic, copy) donBlock dblock;//结束调用

@end

NS_ASSUME_NONNULL_END
