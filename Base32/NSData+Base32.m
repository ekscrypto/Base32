//
//  NSData+Base32.h
//  Buttons
//
//  Created by Dave Poirier on 11-08-25.
//  Copyright 2011 Freshcode. All rights reserved.

#import "NSData+Base32.h"

@implementation NSData (Base32)

+ (NSData *) dataWithBase32String:(NSString *)base32String
{
    CFErrorRef error;
	if (![base32String canBeConvertedToEncoding:NSASCIIStringEncoding]) return nil;

    NSData *base32Data = [base32String dataUsingEncoding:NSASCIIStringEncoding];
    SecTransformRef base32Ref = SecDecodeTransformCreate(kSecBase32Encoding, &error);
    SecTransformSetAttribute(base32Ref, kSecTransformInputAttributeName, base32Data, &error);
    NSData *decodedData = SecTransformExecute(base32Ref, &error);
    CFRelease(base32Ref);
    return [decodedData autorelease];
}

+ (NSData *) dataWithBase64String:(NSString *)base64String
{
    CFErrorRef error;
	if (![base64String canBeConvertedToEncoding:NSASCIIStringEncoding]) return nil;
    
    NSData *base64Data = [base64String dataUsingEncoding:NSASCIIStringEncoding];
    SecTransformRef base64Ref = SecDecodeTransformCreate(kSecBase64Encoding, &error);
    SecTransformSetAttribute(base64Ref, kSecTransformInputAttributeName, base64Data, &error);
    NSData *decodedData = SecTransformExecute(base64Ref, &error);
    CFRelease(base64Ref);
    return [decodedData autorelease];
}

- (NSString *)base32Representation
{
    CFErrorRef error;
    SecTransformRef base32Ref = SecEncodeTransformCreate(kSecBase32Encoding, &error);
    SecTransformSetAttribute(base32Ref, kSecTransformInputAttributeName, self, &error);
    NSData *encodedData = SecTransformExecute(base32Ref, &error);
    CFRelease(base32Ref);
    return [[[NSString alloc] initWithData:encodedData encoding:NSASCIIStringEncoding] autorelease];
}

- (NSString *)base64Representation
{
    CFErrorRef error;
    SecTransformRef base64Ref = SecEncodeTransformCreate(kSecBase64Encoding, &error);
    SecTransformSetAttribute(base64Ref, kSecTransformInputAttributeName, self, &error);
    NSData *encodedData = SecTransformExecute(base64Ref, &error);
    CFRelease(base64Ref);
    return [[[NSString alloc] initWithData:encodedData encoding:NSASCIIStringEncoding] autorelease];
}
@end
