//
//  ImageTransformer.m
//  Homepwner
//
//  Created by wayne on 14-4-15.
//  Copyright (c) 2014年 wayne. All rights reserved.
//

#import "ImageTransformer.h"

@implementation ImageTransformer
+(Class)transformedValueClass
{
    return [NSData class];
}
-(id)transformedValue:(id)value
{
    if(!value){
        return nil;
    }
    if([value isKindOfClass:[NSData class]]){
        return value;
    }
    return UIImagePNGRepresentation(value);
}
-(id)reverseTransformedValue:(id)value{
    return [UIImage imageWithData:value];
}
@end
