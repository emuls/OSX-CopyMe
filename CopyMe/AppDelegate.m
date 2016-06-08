//
//  AppDelegate.m
//  PasteMe
//
//  Created by rex jolley on 6/8/16.
//  Copyright © 2016 kr4. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(id)init{
	self = [super init];
	if(self){
		self.pasteString = [AppDelegate getSecureUserPreference:@"PASTE_STRING" withDefaultValue:@"PASTE ME"];
	}
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag{
	[self copyToClipboard];
	return false;
}

-(void)setPasteString:(NSString *)pasteString{
	_pasteString = pasteString;
	[AppDelegate setSecureUserPreference:pasteString forKey:@"PASTE_STRING" withkSecAttrAccessibility:NO];
}

-(void)copyToClipboard{
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	NSArray *types = [NSArray     arrayWithObjects:NSStringPboardType, nil];
	[pb declareTypes:types owner:self];
	[pb setString:self.pasteString forType:NSStringPboardType];
}

/* *
 * Saves a preference in the user's keychain (encrypted).  The value must be an object
 * that can be serialized into a NSKeyedArchiver.
 */
+ (BOOL)setSecureUserPreference:(id)value forKey:(NSString *)preferenceKey withkSecAttrAccessibility:(BOOL)accessibility {
	CFTypeRef secAttrAccessibility = kSecAttrAccessibleWhenUnlockedThisDeviceOnly;
	if(accessibility){
		secAttrAccessibility = kSecAttrAccessibleWhenUnlocked;
	}
	if (value == nil) {
		return NO;
	}
	
	NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								  (__bridge id)kSecClassGenericPassword, kSecClass,
								  preferenceKey, kSecAttrService,
								  preferenceKey, kSecAttrAccount,
								  nil];
	
	OSStatus returnCode = SecItemDelete((__bridge CFDictionaryRef)query);
	if (returnCode != errSecSuccess && returnCode != errSecItemNotFound) {
		// Could not delete
		return NO;
	}
	
	[query setObject:(__bridge id)secAttrAccessibility forKey:(__bridge id)kSecAttrAccessible];
	[query setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(__bridge id)kSecValueData];
	if (SecItemAdd((__bridge CFDictionaryRef)query, NULL) != errSecSuccess) {
		return NO;
	}
	
	return YES;
}

/* *
 * Retrieves a preference from the user's keychain.
 */
+ (id)getSecureUserPreference:(NSString *)preferenceKey withDefaultValue:(id)defaultValue {
	NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
						   (__bridge id)kSecClassGenericPassword, kSecClass,
						   preferenceKey, kSecAttrService,
						   preferenceKey, kSecAttrAccount,
						   kCFBooleanTrue, kSecReturnData,
						   kSecMatchLimitOne, kSecMatchLimit,
						   nil];
	
	CFDataRef data = nil;
	if (SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&data) == errSecSuccess) {
		@try {
			NSData *castData = (__bridge NSData *)data;
			return [NSKeyedUnarchiver unarchiveObjectWithData:castData];
		}
		@catch (NSException *exception) {
			return defaultValue;
		}
	} else {
		return defaultValue;
	}
}
@end
