//
//  MyViewController.m
//  Stock
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 stock. All rights reserved.
//

#import "MyViewController.h"
#import "MineViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"
#import "MyInforViewController.h"
#import "FeedBackViewController.h"

#define CELL_HIGH 60.0f

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *registerTime;

@property (weak, nonatomic) IBOutlet UILabel *optionalNum;

@property (weak, nonatomic) IBOutlet UILabel *messageNum;

@property (weak, nonatomic) IBOutlet UIView *loginBtnBg;

@property (weak, nonatomic) IBOutlet UITableView *setingTable;

@property (strong, nonatomic)   NSArray     *cellTitle;
@property (strong, nonatomic)   NSArray     *cellImgName;

@end

@implementation MyViewController

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createDate];
    [_headerImg.layer setCornerRadius:_headerImg.frame.size.width/2];
    _headerImg.layer.masksToBounds =YES;
    _headerImg.userInteractionEnabled = YES;
    
    _nickName.text = [Config shareInstance].login.moblie;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:self.headerImg.bounds];
    [btn addTarget:self action:@selector(clickImageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.headerImg addSubview:btn];
    
    if ([Config shareInstance].islogin) {
        self.loginBtnBg.hidden = YES;
    }
}

- (void)clickImageBtn {
    MyInforViewController *myinforVC = [[UIStoryboard storyboardWithName:@"Base" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyInfor"];
    [self.navigationController pushViewController:myinforVC animated:YES];
}

- (IBAction)clickLoginBtn:(UIButton *)sender {
    [self tipsForLoginSuccess:^{
        self.loginBtnBg.hidden = YES;
        _nickName.text = [Config shareInstance].login.moblie;
    }];
}

/**
 初始化设置table的cell数据与icon
 */
- (void)createDate {
    _cellTitle = @[@"设置",@"喜欢就评分吧",@"意见反馈",@"关于我们",@"退出登录"];
    _cellImgName = @[@"icon_my_setting",@"icon_my_like",@"icon_my_opinion",@"icon_my_we",@"icon_my_quit"];
}

#pragma mark -- TableViewDelegateAndDateSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HIGH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = [UIImage imageNamed:_cellImgName[indexPath.row]];
    cell.textLabel.text = _cellTitle[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 59, CGRectGetWidth(_setingTable.frame)-10, 1)];
    [line setBackgroundColor:[Utils colorFromHexRGB:@"D8D8D8"]];
    [cell.contentView addSubview:line];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3) {
        [self jumpToClickCellViewController:indexPath.row];
    } else if (indexPath.row == 4) {
        [self successAlert:@"是否登出" one:^{
            NSLog(@"登出成功");
        } two:nil oneT:@"确定" twoT:@"取消"];
    } else if (indexPath.row == 1) {
        NSLog(@"转跳App Store评价");
    }
}

- (void)jumpToClickCellViewController:(NSInteger)row {
    if (row == 0) {
        SettingViewController *settingVC = [[UIStoryboard storyboardWithName:@"Base" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Setting"];
        settingVC.topTitle = _cellTitle[row];
        [self.navigationController pushViewController:settingVC animated:YES];
    } else if (row == 2) {
        FeedBackViewController *feedbackVC = [[UIStoryboard storyboardWithName:@"Base" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FeedBack"];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    } else if (row == 3) {
        AboutViewController *aboutVC = [[UIStoryboard storyboardWithName:@"Base" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"About"];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect newFrame = _setingTable.frame;
    newFrame.size.height = _cellTitle.count*CELL_HIGH;
    if (newFrame.size.height < _setingTable.frame.size.height) {
        _setingTable.scrollEnabled = NO;
    }
    _setingTable.frame = newFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
