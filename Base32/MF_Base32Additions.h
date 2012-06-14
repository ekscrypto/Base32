//
//  MF_Base32Additions.h
//  Base32 -- RFC 4648 compatible implementation
//  see http://www.ietf.org/rfc/rfc4648.txt for more details
//
//  Designed to be compiled with Automatic Reference Counting
//
//  Created by Dave Poirier on 12-06-14.
//  Public Domain
//

#import <Foundation/Foundation.h>

#define NSBase32StringEncoding  0x4D467E32

@interface NSString (Base32Addition)
-(NSString *)stringByEncodingBase32;
-(NSString *)stringByDecodingBase32;
@end

@interface NSData (Base32Addition)
+(NSData *)dataWithBase32Encoding:(NSString *)base32encoding;
-(NSString *)base32Encoding;
@end

@interface MF_Base32Codec
+(NSData *)dataFromBase32Encoding:(NSString *)encoding;
+(NSString *)base32EncodingFromData:(NSData *)data;
@end
