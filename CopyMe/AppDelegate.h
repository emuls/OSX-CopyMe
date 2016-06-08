//
//  AppDelegate.h
//  PasteMe
//
//  Created by rex jolley on 6/8/16.
//  Copyright © 2016 kr4. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property(nonatomic, retain) NSString *pasteString;

-(void)setPasteString:(NSString *)pasteString;
-(void)copyToClipboard;

@end

