//
//  ContentViewController.h
//  AviaSearch
//
//  Created by Илья Павлов on 13.08.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController

@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int index;

@end

NS_ASSUME_NONNULL_END
