#import "gDvorak.h"

BOOL enabled = YES;

void loadPreferences() {
	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ninjaprawn.gdvorak.prefs.plist"];
    enabled = (preferences[@"enabled"] != nil ? [preferences[@"enabled"] boolValue] : YES);
}

%hook GKBSoftKeyboardFragmentView

%new -(void)activateMeme {
	// Top row: y = 0
	// Middle row: y = 56
	// Bottom row: y = 112
	/*
	key_pos_1_1 = Q, key_pos_1_2 = W, key_pos_1_3 = E, key_pos_1_4 = R, key_pos_1_5 = T, key_pos_1_6 = Y, key_pos_1_7 = U, key_pos_1_8 = I,  key_pos_1_9 = O, key_pos_1_10 = P,
	       key_pos_2_1 = A, key_pos_2_2 = S, key_pos_2_3 = D, key_pos_2_4 = F, key_pos_2_5 = G, key_pos_2_6 = H, key_pos_2_7 = J, key_pos_2_8 = K,  key_pos_2_9 = L
		      key_pos_shift, key_pos_3_1 = Z, key_pos_3_2 = X, key_pos_3_3 = C, key_pos_3_4 = V, key_pos_3_5 = B, key_pos_3_6 = N, key_pos_3_7 = M, key_pos_del
	*/
	loadPreferences();
	if (enabled && self.allSoftKeys[@"key_pos_1_1"] && [((GKBStringMapEntry*)[((GKBSoftKeyView*)self.allSoftKeys[@"key_pos_switch_to_symbol"]).softKeyDef.labelsArray objectAtIndex:0]).value isEqualToString:@"123"]) {
		NSArray *rowOne = @[@"key_pos_shift", @"key_pos_1_10", @"key_pos_1_6", @"key_pos_2_4", @"key_pos_2_5", @"key_pos_3_3", @"key_pos_1_4",@"key_pos_2_9", @"key_pos_del"];
		NSArray *rowTwo = @[@"key_pos_2_1", @"key_pos_1_9", @"key_pos_1_3", @"key_pos_1_7", @"key_pos_1_8", @"key_pos_2_3", @"key_pos_2_6", @"key_pos_1_5", @"key_pos_3_6", @"key_pos_2_2"];
		NSArray *rowThree = @[@"key_pos_1_1", @"key_pos_2_7", @"key_pos_2_8", @"key_pos_3_2", @"key_pos_3_5", @"key_pos_3_7", @"key_pos_1_2", @"key_pos_3_4", @"key_pos_3_1"];
		float currentX = (self.frame.size.width - (41.2*7 + 51.5*2))/2;
		float currentY = 0;
		for (NSString *key in rowOne) {
			if ([key isEqualToString:@"key_pos_shift"] || [key isEqualToString:@"key_pos_del"]) {
				((GKBSoftKeyView*)self.allSoftKeys[key]).frame = CGRectMake(currentX, currentY, 51.5, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.height);
				if ([key isEqualToString:@"key_pos_del"]) {
					((GKBSoftKeyView*)self.allSoftKeys[key]).subviews[0].frame = CGRectMake(3, ((GKBSoftKeyView*)self.allSoftKeys[key]).subviews[0].frame.origin.y, ((GKBSoftKeyView*)self.allSoftKeys[key]).subviews[0].frame.size.width, ((GKBSoftKeyView*)self.allSoftKeys[key]).subviews[0].frame.size.height);
				}
				currentX += 51.5;
			} else if ([key isEqualToString:@"key_pos_2_9"]) {
				((GKBSoftKeyView*)self.allSoftKeys[key]).frame = CGRectMake(currentX, currentY, 41.2, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.height);
				currentX += 41.2;
			} else {
				((GKBSoftKeyView*)self.allSoftKeys[key]).frame = CGRectMake(currentX, currentY, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.width, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.height);
				currentX += ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.width;
			}
		}
		currentY += 56;
		currentX = -21.8;
		for (NSString *key in rowTwo) {
			((GKBSoftKeyView*)self.allSoftKeys[key]).frame = CGRectMake(currentX, currentY, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.width, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.height);
			currentX += ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.width;
		}
		currentY += 56;
		currentX = 21.8;
		for (NSString *key in rowThree) {
			((GKBSoftKeyView*)self.allSoftKeys[key]).frame = CGRectMake(currentX, currentY, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.width, ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.height);
			currentX += ((GKBSoftKeyView*)self.allSoftKeys[key]).frame.size.width;
		}
	}
}

- (void)updateLayoutIfNeeded {
	%orig();
	[self activateMeme];
}

- (void)layoutSubviews {
	%orig();
	[self activateMeme];
}

- (void)setSoftKeyDef:(id)arg1 toViewWithId:(id)arg2 {
	%orig();
	[self activateMeme];
}


%end

/*
"key_pos_1_1" = "<GKBSoftKeyView: 0x15f75e4c0; frame = (0 112; 41.2 56); layer = <CALayer: 0x15f751d00>>";
	   "key_pos_1_10" = "<GKBSoftKeyView: 0x15f5dfac0; frame = (370.8 0; 41.2 56); layer = <CALayer: 0x15f5dfc60>>";
	   "key_pos_1_2" = "<GKBSoftKeyView: 0x15f75e940; frame = (41.2 0; 41.2 56); layer = <CALayer: 0x15f75eae0>>";
	   "key_pos_1_3" = "<GKBSoftKeyView: 0x15f75eeb0; frame = (82.4 0; 41.2 56); layer = <CALayer: 0x15f75f050>>";
	   "key_pos_1_4" = "<GKBSoftKeyView: 0x15f5dda80; frame = (123.6 0; 41.2 56); layer = <CALayer: 0x15f5ddc20>>";
	   "key_pos_1_5" = "<GKBSoftKeyView: 0x15f5ddfe0; frame = (164.8 0; 41.2 56); layer = <CALayer: 0x15f5de180>>";
	   "key_pos_1_6" = "<GKBSoftKeyView: 0x15f5de540; frame = (206 0; 41.2 56); layer = <CALayer: 0x15f5de6e0>>";
	   "key_pos_1_7" = "<GKBSoftKeyView: 0x15f5deaa0; frame = (247.2 0; 41.2 56); layer = <CALayer: 0x15f5dec40>>";
	   "key_pos_1_8" = "<GKBSoftKeyView: 0x15f5df060; frame = (288.4 0; 41.2 56); layer = <CALayer: 0x15f5df000>>";
	   "key_pos_1_9" = "<GKBSoftKeyView: 0x15f5df560; frame = (329.6 0; 41.2 56); layer = <CALayer: 0x15f5df700>>";
	   "key_pos_2_1" = "<GKBSoftKeyView: 0x15f5e0020; frame = (0 56; 63 56); layer = <CALayer: 0x15f5e01c0>>";
	   "key_pos_2_2" = "<GKBSoftKeyView: 0x15f5e0580; frame = (63 56; 41.2 56); layer = <CALayer: 0x15f5e0720>>";
	   "key_pos_2_3" = "<GKBSoftKeyView: 0x15f5e0ae0; frame = (104.2 56; 41.2 56); layer = <CALayer: 0x15f5e0c80>>";
	   "key_pos_2_4" = "<GKBSoftKeyView: 0x15f5e1040; frame = (145.4 56; 41.2 56); layer = <CALayer: 0x15f5e11e0>>";
	   "key_pos_2_5" = "<GKBSoftKeyView: 0x15f5e15a0; frame = (186.6 56; 41.2 56); layer = <CALayer: 0x15f5e1740>>";
	   "key_pos_2_6" = "<GKBSoftKeyView: 0x15f5e1b00; frame = (227.8 56; 41.2 56); layer = <CALayer: 0x15f5e1ca0>>";
	   "key_pos_2_7" = "<GKBSoftKeyView: 0x15f5e2060; frame = (269 56; 41.2 56); layer = <CALayer: 0x15f5e2200>>";
	   "key_pos_2_8" = "<GKBSoftKeyView: 0x15f5e25c0; frame = (310.2 56; 41.2 56); layer = <CALayer: 0x15f5e2760>>";
	   "key_pos_2_9" = "<GKBSoftKeyView: 0x15f5e2b20; frame = (351.4 56; 62 56); layer = <CALayer: 0x15f5e2cc0>>";
	   "key_pos_3_1" = "<GKBSoftKeyView: 0x15f5e35e0; frame = (61.8 112; 41.2 56); layer = <CALayer: 0x15f5e3780>>";
	   "key_pos_3_2" = "<GKBSoftKeyView: 0x15f5e3b40; frame = (103 112; 41.2 56); layer = <CALayer: 0x15f5e3ce0>>";
	   "key_pos_3_3" = "<GKBSoftKeyView: 0x15f5e40a0; frame = (144.2 112; 41.2 56); layer = <CALayer: 0x15f5e4240>>";
	   "key_pos_3_4" = "<GKBSoftKeyView: 0x15f5e4600; frame = (185.4 112; 41.2 56); layer = <CALayer: 0x15f5e47a0>>";
	   "key_pos_3_5" = "<GKBSoftKeyView: 0x15f5e4b60; frame = (226.6 112; 41.2 56); layer = <CALayer: 0x15f5e4d00>>";
	   "key_pos_3_6" = "<GKBSoftKeyView: 0x15f5e50c0; frame = (267.8 112; 41.2 56); layer = <CALayer: 0x15f5e5260>>";
	   "key_pos_3_7" = "<GKBSoftKeyView: 0x15f5e5620; frame = (309 112; 41.2 56); layer = <CALayer: 0x15f5e57c0>>";
	   "key_pos_URL_com" = "<GKBSoftKeyView: 0x15f5e8150; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e82f0>>";
	   "key_pos_URL_dot" = "<GKBSoftKeyView: 0x15f5e7670; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e7810>>";
	   "key_pos_URL_slash" = "<GKBSoftKeyView: 0x15f5e7be0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e7d80>>";
	   "key_pos_action" = "<GKBSoftKeyView: 0x15f5eb240; frame = (309 163; 103 55); layer = <CALayer: 0x15f5eb3e0>>";
	   "key_pos_del" = "<GKBSoftKeyView: 0x15f5e5b80; frame = (350.2 112; 61.8 56); layer = <CALayer: 0x15f5e5d20>>";
	   "key_pos_email_at" = "<GKBSoftKeyView: 0x15f5e8c30; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e8dd0>>";
	   "key_pos_email_dot" = "<GKBSoftKeyView: 0x15f5e91a0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e9340>>";
	   "key_pos_email_space" = "<GKBSoftKeyView: 0x15f5e86c0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e8860>>";
	   "key_pos_emoji" = "<GKBSoftKeyView: 0x15f5e6bd0; frame = (97.85 163; 42.7923 55); layer = <CALayer: 0x15f5e6650>>";
	   "key_pos_globe" = "<GKBSoftKeyView: 0x15f5e6670; frame = (51.5 163; 46.35 55); layer = <CALayer: 0x15f5e6810>>";
	   "key_pos_period" = "<GKBSoftKeyView: 0x15f5eb7a0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5eb940>>";
	   "key_pos_shift" = "<GKBSoftKeyView: 0x15f5e3080; frame = (0 112; 61.8 56); layer = <CALayer: 0x15f5e3220>>";
	   "key_pos_small_return" = "<GKBSoftKeyView: 0x15f5ebd20; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5ebec0>>";
	   "key_pos_space" = "<GKBSoftKeyView: 0x15f5e7110; frame = (140.642 163; 168.358 55); layer = <CALayer: 0x15f5e72b0>>";
	   "key_pos_switch_to_symbol" = "<GKBSoftKeyView: 0x15f5e60e0; frame = (0 163; 51.5 55); layer = <CALayer: 0x15f5e6280>>";
	   "key_pos_twitter_at" = "<GKBSoftKeyView: 0x15f5e9710; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e98b0>>";
	   "key_pos_twitter_sharp" = "<GKBSoftKeyView: 0x15f5e9ca0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e9e40>>";
	   "key_pos_websearch_action" = "<GKBSoftKeyView: 0x15f5eacd0; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5eae70>>";
	   "key_pos_websearch_dot" = "<GKBSoftKeyView: 0x15f5ea760; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5ea900>>";
	   "key_pos_websearch_space" = "<GKBSoftKeyView: 0x15f5ea210; frame = (0 0; 0 0); hidden = YES; layer = <CALayer: 0x15f5e9c80>>";
*/
