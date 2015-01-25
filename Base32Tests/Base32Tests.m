//
//  Base32Tests.m
//  Base32Tests
//
//  Created by Matt Rubin on 1/25/15.
//  Copyright (c) 2015 Freshcode. All rights reserved.
//

@import XCTest;
@import Base32;


@interface Base32Tests : XCTestCase
@end


@implementation Base32Tests

- (void)testRandomData
{
    for (int i = 0; i < 300; i++) {
        NSData *randomDataBlock = [self randomDataBlock];
        NSString *base32Rep = [randomDataBlock base32String];
        NSData *revertedDataBlock = [NSData dataWithBase32String:base32Rep];
        XCTAssertTrue([randomDataBlock isEqualToData:revertedDataBlock],
                      @"%@\n    original data block: %@\n    reverted data block: %@",
                      base32Rep, randomDataBlock, revertedDataBlock);
    }
}

- (NSData *)randomDataBlock
{
#define MaxRandomDataLength 64
    unsigned char bytes[MaxRandomDataLength];
    long dataLength = random() % 64;
    for (int i = 0; i < dataLength; i++) {
        bytes[i] = random() % 256;
    }

    return [[NSData alloc] initWithBytes:bytes length:dataLength];
}

@end
