//
//  WZXItemsTableViewController.m
//  Homepwner
//
//  Created by wayne on 14-3-24.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "WZXItemsTableViewController.h"
#import "Item.h"
#import "ItemStore.h"
#import "ItemDetailVC.h"

@interface WZXItemsTableViewController ()
@property (nonatomic,strong)IBOutlet UIView *headerView;
@end

@implementation WZXItemsTableViewController
-(instancetype)init
{
    self=[super initWithStyle:UITableViewStylePlain];
    if(self){
        for(int i=0;i<5;i++){
            [[ItemStore sharedStore] addStoreItem];
        }
        UINavigationItem *item=self.navigationItem;
        item.title=@"wayne";
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addNewItem:)];
        item.leftBarButtonItem=barButton;
        item.rightBarButtonItem=self.editButtonItem;
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCell"];
//    UIView *header=self.headerView;
//    [self.tableView setTableHeaderView:header];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    NSLog(@"%@",[[[[ItemStore sharedStore] allItems] objectAtIndex:0] description]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    // Return the number of rows in the section.
    return [[[ItemStore sharedStore] allItems] count];
}
//-(UIView *)headerView
//{
//    if(!_headerView){
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
//                                      owner:self
//                                    options:nil];
//    }
//    return _headerView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];
    NSArray *allItems=[[ItemStore sharedStore] allItems];
    
    cell.textLabel.text=[allItems[indexPath.row] description];
    
    // Configure th
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemDetailVC *detailVC=[[ItemDetailVC alloc] init];
    NSArray *allItems=[[ItemStore sharedStore] allItems];
    detailVC.item=allItems[indexPath.row];
    [self.navigationController pushViewController:detailVC
                                         animated:YES
     ];
}
//-(IBAction)toggleEdit:(id)sender
//{
//    if(self.isEditing){
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        [self setEditing:NO animated:YES];
//    }
//    else{
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}
-(IBAction)addNewItem:(id)sender
{
    //create new item
    Item *newItem=[[ItemStore sharedStore] addStoreItem];
    //his position
    NSInteger hisRow=[[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    //find his indexpath
    NSIndexPath *newItemPath=[NSIndexPath indexPathForRow:hisRow inSection:0];
    //insert into table
    //indexpath include the info of row index and section index
    [self.tableView insertRowsAtIndexPaths:@[newItemPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *allItems=[[ItemStore sharedStore] allItems];
        Item *removeItem=allItems[indexPath.row];
        [[ItemStore sharedStore] removeStoreItem:removeItem];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[ItemStore sharedStore] moveItemPositon:fromIndexPath.row to:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
