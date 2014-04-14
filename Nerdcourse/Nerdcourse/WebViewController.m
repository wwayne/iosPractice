//
//  WebViewController.m
//  Nerdcourse
//
//  Created by wayne on 14-4-13.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)loadView
{
    UIWebView *webView=[[UIWebView alloc] init];
    webView.scalesPageToFit=YES;
    self.view=webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setUrl:(NSURL *)url
{
    _url=url;
    if(_url){
        NSURLRequest *request=[NSURLRequest requestWithURL:_url];
        [(UIWebView *)self.view loadRequest:request];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if(barButtonItem==self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem=nil;
    }
}
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title=@"Course";
    self.navigationItem.leftBarButtonItem=barButtonItem;
}
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
