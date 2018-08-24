//
//  ViewController.m
//  NavigationControllerSetAlpha
//
//  Created by MrHuang on 18/8/24.
//  Copyright © 2018年 Mrhuang. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"



#define originalHeight 200
#define originalOffsetY -244

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置navigationBar透明 注意：在导航条和导航条的控制上直接设置透明度是无效。
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    
    
    // 标题
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"个人详情页";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0];
    
    self.navigationItem.titleView = titleLabel;
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //偏移量 偏移量 = 当前点的位置 - 原始点的位置
    CGFloat offSet = scrollView.contentOffset.y - originalOffsetY;
    
    //设置背景View的高度 根据TableView的偏移量来求得 最原始的高度 - 偏移量
    CGFloat h = originalHeight - offSet;
    
    
    // 当这高度到达一定值的时候保持不动停留在上面显示。
    if (h < 64) {
        h = 64;
    }
    self.viewHeight.constant = h;
    
    
    // 透明度
    CGFloat alpha = offSet * 1 / 136.0;
    
    // 当透明度为1的时候 系统会自动设置成半透明效果
    if (alpha >= 1) {
        alpha = 0.999;
    }
    
    // 将色彩转为图片
    UIColor * alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage * alphaImage = [UIImage imageWithColor:alphaColor];
    
    // 修改导航条背景
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    
    
    //修改标题透明度
    UILabel * titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.textColor = [UIColor colorWithWhite:0 alpha:alpha];

}

#pragma mark - dataSoource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 40;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
       cell.textLabel.text = @"test";
    
    return cell;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
