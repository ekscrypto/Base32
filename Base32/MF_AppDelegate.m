//
//  MF_AppDelegate.m
//  Base32
//
//  Created by Dave Poirier on 12-06-14.
//  Public Domain
//

#import "MF_AppDelegate.h"
#import "MF_Base32Additions.h"

@implementation MF_AppDelegate

@synthesize window = _window;
@synthesize textField = _textField;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
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
            NSLog(@"FAILED: %@\noriginal data block: %@\n reverted data block: %@", base32Rep, randomDataBlock, revertedDataBlock);
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
    long dataLength = arc4random() % 64;
    for(int i = 0; i < dataLength; i++ ) {
        bytes[i] = (unsigned char)(arc4random() % 256);
    }
    
    return [[NSData alloc] initWithBytes:bytes length:dataLength];
}
-(void)encode:(id)sender
{
    NSString *raw = [_textField stringValue];
    NSString *encoded = [raw base32String];
    [_textField setStringValue:encoded];
}

-(void)decode:(id)sender
{
    NSString *encoded = [_textField stringValue];
    NSData *data = [NSData dataWithBase32String:encoded];
    NSString *raw = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [_textField setStringValue:raw];
}

@end
