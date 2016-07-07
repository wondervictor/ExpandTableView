//
//  MainViewController.m
//  ExpandTableView
//
//  Created by VicChan on 7/7/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "MainViewController.h"
#import "GroupSection.h"
#import <objc/runtime.h>


char *const key = "buttonKey";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *listData;


@end

static NSString *cellIndentifer = @"cell";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self initData];


}


- (void)initData {
    
    self.listData = [NSMutableArray new];
    NSArray *cellData = @[@"One",@"Two",@"Three",@"Four",@"Five"];
    for (int i = 0; i < 5; i ++) {
        GroupSection *section = [GroupSection new];
        section.groupData = cellData;
        section.groupName = [NSString stringWithFormat:@"Group %d", i];
        section.count = cellData.count;
        section.isExpanded = NO;
        [_listData addObject:section];
    }
    
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroupSection *group = (GroupSection *)[self.listData objectAtIndex:section];
    return group.isExpanded == NO ? 0:group.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    GroupSection *sectionInfo = (GroupSection *)[self.listData objectAtIndex:section];
    
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:sectionView.bounds];
    button.tag = section;
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitle:sectionInfo.groupName forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [sectionView addSubview:button];
    
    
    UIImageView *arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(10,12 , 20, 20)];
    arrowView.image = [UIImage imageNamed:@"arrow"];
    [sectionView addSubview:arrowView];
    objc_setAssociatedObject(button, key, arrowView, OBJC_ASSOCIATION_RETAIN);
    if (!sectionInfo.isExpanded) {
        arrowView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
    return sectionView;
}


- (void)buttonPressed:(UIButton *)sender {
    GroupSection *group = (GroupSection *)[_listData objectAtIndex:sender.tag];
    UIImageView *arrow = (UIImageView *)objc_getAssociatedObject(sender, key);
    
    if (group.isExpanded) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            arrow.transform = CGAffineTransformMakeRotation(-M_PI/2);
            
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            arrow.transform = CGAffineTransformMakeRotation(M_PI/2);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    group.isExpanded = !group.isExpanded;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifer];
    }
    GroupSection *section = (GroupSection *)[self.listData objectAtIndex:indexPath.section];
    cell.textLabel.text = section.groupData[indexPath.row];
    // Configure the cell...
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
