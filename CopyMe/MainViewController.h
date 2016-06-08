//
//  ViewController.h
//  PasteMe
//
//  Created by rex jolley on 6/8/16.
//  Copyright © 2016 kr4. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController

@property(nonatomic, weak) IBOutlet NSTextField *pasteTextField;
@property(nonatomic, weak) IBOutlet NSButton *setButton;
@property(nonatomic, weak) IBOutlet NSButton *clipButton;

- (IBAction)setButtonClicked:(id)sender;
- (IBAction)copyButtonClicked:(id)sender;

@end

