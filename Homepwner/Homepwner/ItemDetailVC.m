//
//  ItemDetailVC.m
//  Homepwner
//
//  Created by wayne on 14-3-26.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ItemDetailVC.h"
#import "Item.h"

@interface ItemDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *serial;
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (weak, nonatomic) IBOutlet UILabel *data;


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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    Item *item=self.item;
    item.itemName=self.name.text;
    item.serialNumber=self.serial.text;
    item.valueInDollars=[self.value.text intValue];
}
-(void)setItem:(Item *)item{
    _item=item;
    self.navigationItem.title=item.itemName;
}
@end
