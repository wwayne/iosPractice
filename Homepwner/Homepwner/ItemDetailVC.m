//
//  ItemDetailVC.m
//  Homepwner
//
//  Created by wayne on 14-3-26.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ItemDetailVC.h"
#import "Item.h"
#import "ImageStore.h"

@interface ItemDetailVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *serial;
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@end

@implementation ItemDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Item *item=self.item;
    self.name.text=item.itemName;
    self.serial.text=item.serialNumber;
    self.value.text=[NSString stringWithFormat:@"%d",item.valueInDollars];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.data.text=[dateFormatter stringFromDate:[NSDate date]];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    Item *item=self.item;
    if(item.itemImage){
       self.image.image=item.itemImage;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    Item *item=self.item;
    item.itemName=self.name.text;
    item.serialNumber=self.serial.text;
    item.valueInDollars=[self.value.text intValue];
    if(self.image.image){
        ImageStore *imageStore=[ImageStore sharedImage];
        [imageStore addImage:self.image.image
                      forKey:item.uniqueKey];
    }
    
}
-(void)setItem:(Item *)item{
    _item=item;
    self.navigationItem.title=item.itemName;
}
- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *imagePC=[[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePC.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePC.delegate=self;
    [self presentViewController:imagePC
                       animated:YES
                     completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    self.image.image=image;
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)backgroundClick:(id)sender {
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    for (UIView *view in self.view.subviews){
        if([view hasAmbiguousLayout]){
            NSLog(@"ambiguous:%@",view);
        }
    }
}
@end
