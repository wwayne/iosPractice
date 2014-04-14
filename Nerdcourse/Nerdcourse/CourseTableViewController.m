//
//  CourseTableViewController.m
//  Nerdcourse
//
//  Created by wayne on 14-4-13.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "CourseTableViewController.h"
#import "WebViewController.h"


@interface CourseTableViewController ()<NSURLSessionDataDelegate>
@property (nonatomic) NSURLSession *session;
@property (nonatomic,copy) NSArray *course;

@end

@implementation CourseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationController.title=@"Course";
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        self.session=[NSURLSession sessionWithConfiguration:config
                                                   delegate:self
                                              delegateQueue:nil];
        [self fetchData];
    }
    return self;
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *credential=[NSURLCredential credentialWithUser:@"BigNerdRanch"
                                                           password:@"AchieveNerdvana"
                                                        persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
}
-(void)fetchData
{
    NSString *urlString=@"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask=[self.session dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data
                                                                                                          options:0
                                                                                                            error:nil];
                                                       self.course=json[@"courses"];
                                                       NSLog(@"%@",self.course);
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [self.tableView reloadData];
                                                       });
                                                    }];
    [dataTask resume];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"tableCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.course count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    NSDictionary *courseSingle=self.course[indexPath.row];
    cell.textLabel.text=courseSingle[@"title"];
    // Configure the cell...
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course=self.course[indexPath.row];
    NSURL *url=[NSURL URLWithString:course[@"url"]];
    self.webVC.url=url;
    self.webVC.title=course[@"title"];
    if(![self splitViewController]){
       [self.navigationController pushViewController:self.webVC animated:YES];
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

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
