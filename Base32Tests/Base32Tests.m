//
//  Base32Tests.m
//  Base32Tests
//
//  Created by Matt Rubin on 1/25/15.
//  Public Domain
//

@import XCTest;
@import Base32;


@interface Base32Tests : XCTestCase
@end


@implementation Base32Tests

// The values in this test are found in Section 10 of the Base32 RFC
// https://tools.ietf.org/html/rfc4648#section-10
- (void)testRFCValues
{
    NSDictionary *vectors = @{@"":       @"",
                              @"f":      @"MY======",
                              @"fo":     @"MZXQ====",
                              @"foo":    @"MZXW6===",
                              @"foob":   @"MZXW6YQ=",
                              @"fooba":  @"MZXW6YTB",
                              @"foobar": @"MZXW6YTBOI======"};
    [self _testEncodingWithVectors:vectors];
    [self _testDecodingWithVectors:vectors];
}

- (void)testUnpaddedRFCValues
{
    NSDictionary *vectors = @{@"":       @"",
                              @"f":      @"MY",
                              @"fo":     @"MZXQ",
                              @"foo":    @"MZXW6",
                              @"foob":   @"MZXW6YQ",
                              @"fooba":  @"MZXW6YTB",
                              @"foobar": @"MZXW6YTBOI"};
    [self _testDecodingWithVectors:vectors];
}

- (void)testUnpaddedLowercaseRFCValues
{
    NSDictionary *vectors = @{@"":       @"",
                              @"f":      @"my",
                              @"fo":     @"mzxq",
                              @"foo":    @"mzxw6",
                              @"foob":   @"mzxw6yq",
                              @"fooba":  @"mzxw6ytb",
                              @"foobar": @"mzxw6ytboi"};
    [self _testDecodingWithVectors:vectors];
}

- (void)_testEncodingWithVectors:(NSDictionary *)vectors
{
    for (NSString *plaintext in vectors) {
        NSString *ciphertext = vectors[plaintext];

        NSString *encryptedPlaintext = [[plaintext dataUsingEncoding:NSUTF8StringEncoding] base32String];
        XCTAssertEqualObjects(encryptedPlaintext, ciphertext, @"");
    }
}

- (void)_testDecodingWithVectors:(NSDictionary *)vectors
{
    for (NSString *plaintext in vectors) {
        NSString *ciphertext = vectors[plaintext];

        NSString *decryptedCiphertext = [[NSString alloc] initWithData:[NSData dataWithBase32String:ciphertext] encoding:NSUTF8StringEncoding];
        XCTAssertEqualObjects(decryptedCiphertext, plaintext, @"");
    }
}

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
    long dataLength = arc4random() % 64;
    for (int i = 0; i < dataLength; i++) {
        bytes[i] = (unsigned char)(arc4random() % 256);
    }

    return [[NSData alloc] initWithBytes:bytes length:dataLength];
}

@end
