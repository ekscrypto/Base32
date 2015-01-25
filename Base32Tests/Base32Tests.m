//
//  Base32Tests.m
//  Base32Tests
//
//  Created by Matt Rubin on 1/25/15.
//  Copyright (c) 2015 Freshcode. All rights reserved.
//

#import <XCTest/XCTest.h>
@import Base32;


@interface Base32Tests : XCTestCase
@end


@implementation Base32Tests

- (void)testRandomData
{
    int totalTests = 0;
    int totalSuccess = 0;
    int totalFailed = 0;
    for( int i = 0; i < 300; i++ ) {
        NSData *randomDataBlock = [self randomDataBlock];
        NSString *base32Rep = [randomDataBlock base32String];
        NSData *revertedDataBlock = [MF_Base32Codec dataFromBase32String:base32Rep];
        if( [randomDataBlock isEqualToData:revertedDataBlock] ) {
            NSLog(@"SUCCESS: %@", base32Rep);
            totalSuccess++;
        } else {
            XCTFail(@"FAILED: %@\noriginal data block: %@\n reverted data block: %@", base32Rep, randomDataBlock, revertedDataBlock);
            totalFailed++;
        }
        totalTests++;
    }
    NSLog(@"Tests completed with %i failures, %i success out of %i tests", totalFailed, totalSuccess, totalTests);
}

-(NSData *)randomDataBlock
{
#define MaxRandomDataLength 64
    unsigned char bytes[MaxRandomDataLength];
    long dataLength = random() % 64;
    for(int i = 0; i < dataLength; i++ ) {
        bytes[i] = random() % 256;
    }

    return [[NSData alloc] initWithBytes:bytes length:dataLength];
}

@end
