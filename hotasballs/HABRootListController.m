#include "HABRootListController.h"

@implementation HABRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)openGithub {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/p0358/HotAsBalls"]];
}

- (void)openTwitter1 {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com/ZaneHelton"]];
}

- (void)openTwitter2 {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com/p0358"]];
}

- (void)openPayPalMe {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/p0358donate"]];
}

@end
