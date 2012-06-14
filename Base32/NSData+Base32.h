//
//  NSData+Base32.h
//  Buttons
//
//  Created by Dave Poirier on 11-08-25.
//  Copyright 2011 Freshcode. All rights reserved.

#import <Foundation/Foundation.h>


@interface NSData (Base32)
+(NSData *)dataWithBase32String:(NSString *)base32String;
+(NSData *)dataWithBase64String:(NSString *)base64String;
-(NSString *)base32Representation;
-(NSString *)base64Representation;
@end
