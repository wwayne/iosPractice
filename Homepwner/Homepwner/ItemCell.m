//
//  ItemCell.m
//  Homepwner
//
//  Created by wayne on 14-4-10.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ItemCell.h"
@interface ItemCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end
@implementation ItemCell

- (void)awakeFromNib
{
    // Initialization code
    [self updateFont];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateFont)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)updateFont
{
    UIFont *font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.itemName.font=font;
    self.itemSerial.font=font;
    self.itemSerial.font=font;
    
    static NSDictionary *sizeDictionary;
    if(!sizeDictionary){
        sizeDictionary=@{
                         UIContentSizeCategoryExtraSmall:@40,
                         UIContentSizeCategorySmall:@40,
                         UIContentSizeCategoryMedium:@40,
                         UIContentSizeCategoryLarge:@40,
                         UIContentSizeCategoryExtraLarge:@50,
                         UIContentSizeCategoryExtraExtraLarge:@60,
                         UIContentSizeCategoryExtraExtraExtraLarge:@70
                         };
    }
    NSString *userChoose=[[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *size=sizeDictionary[userChoose];
    self.heightConstraint.constant=[size floatValue];
    self.widthConstraint.constant=[size floatValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tapImage:(id)sender {
    if(self.tapButton){
        self.tapButton();
    }
}

@end
