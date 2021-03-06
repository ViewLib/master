//
//  BrokersRatingTableViewCell.m
//  Stock
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 stock. All rights reserved.
//

#import "BrokersRatingTableViewCell.h"
#import "ValueCollection.h"

@implementation BrokersRatingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleAry = @[@"评级变化",@"平均价格",@"券商评论"];
    [_menuCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"meunCall"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_menuCollection setCollectionViewLayout:layout];
}

- (void)setStockCode:(NSString *)stockCode {
    if (stockCode) {
        _stockCode = stockCode;
    }
    
    _currentDic = [Config shareInstance].stockDic[_stockCode];
    if (_currentDic[@"gradleModelList"]) {
        [self setInformation:_currentDic[@"gradleModelList"]];
    } else {
        [self getStockGrade];
    }
}

- (void)getStockGrade {
    WS(self)
    [[HttpRequestClient sharedClient]getStockgrade:@{@"stockCode": self.stockCode} request:^(NSString *resultMsg, id dataDict, id error) {
        if ([dataDict[@"resultCode"] intValue] == 200) {
            NSMutableDictionary *currentStockDic = [Config shareInstance].stockDic[self.stockCode];
            [currentStockDic setValue:dataDict[@"compareList"] forKey:@"compareList"];
            [[Config shareInstance].stockDic setValue:currentStockDic forKey:self.stockCode];
            
            [selfWeak setInformation:dataDict[@"gradleModelList"]];
        }
    }];
}

- (void)setInformation:(NSArray *)dicAry {
    self.stockGradeAry = dicAry.mutableCopy;
    [self pjbhView];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (ValueCollection *)pjbhView{
    if (!_pjbhView) {
        _pjbhView = [[ValueCollection alloc] initWithType:@"PJBH" Value:self.stockGradeAry];
        CGRect new = _pjbhView.frame;
        new.origin.x = 0;
        new.origin.y = 0;
        new.size.width = K_FRAME_BASE_WIDTH;
        new.size.height = 200;
        _pjbhView.frame = new;
        [self.valueView addSubview:_pjbhView];
    }
    return _pjbhView;
}

#pragma mark CollectionViewDelegateAndDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleAry.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize frame = CGSizeMake(60, 33);
    return frame;
}

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    return UIEdgeInsetsMake ( 0 , 10 , 0 , 10 );
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"meunCall" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 33)];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTag:999000];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[Utils colorFromHexRGB:@"999999"]];
    [label setText:self.titleAry[indexPath.item]];
    [cell.contentView addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.contentView.frame)-2, 60, 2)];
    [line setBackgroundColor:MAIN_COLOR];
    [line setCenterX:label.centerX];
    [line setTag:999001];
    [line setHidden:YES];
    [cell.contentView addSubview:line];
    
    if (indexPath.item == 0) {
        [label setTextColor:[UIColor blackColor]];
        line.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < self.titleAry.count; i++) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        UILabel *lab = [cell viewWithTag:999000];
        UIView *line = [cell viewWithTag:999001];
        if (i == indexPath.item) {
            [lab setTextColor:[UIColor blackColor]];
            line.hidden = NO;
        } else {
            [lab setTextColor:[Utils colorFromHexRGB:@"999999"]];
            line.hidden = YES;
        }
    }
}

- (void)clickBtn:(UIButton *) btn {
    btn.selected = !btn.selected;
    NSLog(@"%@",btn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
