//
//  HomeTableViewCell.h
//  Stock
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 stock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockEntity.h"

typedef void(^clickMenuBlock)(void);

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseWidth;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *code;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *stopLabel;

@property (weak, nonatomic) IBOutlet UIView *upView;

@property (weak, nonatomic) IBOutlet UILabel *upValue;

@property (weak, nonatomic) IBOutlet UIView *downView;

@property (weak, nonatomic) IBOutlet UILabel *downValue;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downWidth;

@property (assign, nonatomic)   float       percentage;

@property (strong, nonatomic)   UIView      *pView;

@property (copy, nonatomic) clickMenuBlock  clickMenuBlock;

- (void)updateCell:(StockObjEntity *)entity;

@end
