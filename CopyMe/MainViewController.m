//
//  ViewController.m
//  PasteMe
//
//  Created by rex jolley on 6/8/16.
//  Copyright © 2016 kr4. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.pasteTextField setStringValue:[[[NSApplication sharedApplication] delegate] pasteString]];
}

- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];

	// Update the view, if already loaded.
}

- (IBAction)setButtonClicked:(id)sender {
	[[[NSApplication sharedApplication] delegate] setPasteString:self.pasteTextField.stringValue];
}

- (IBAction)copyButtonClicked:(id)sender {
	[[[NSApplication sharedApplication] delegate] copyToClipboard];
}
@end
