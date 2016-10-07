@interface GKBStringMapEntry : NSObject
@property(retain, nonatomic) NSString *value;
@end

@interface PBMutableArray: NSObject
- (id)objectAtIndex:(unsigned long long)arg1;
@end

@interface GKBSoftKeyDef : NSObject
@property(retain, nonatomic) PBMutableArray *labelsArray;
@end

@interface GKBSoftKeyView : UIView
@property(retain, nonatomic) GKBSoftKeyDef *softKeyDef;
@end

@interface GKBSoftKeyboardView : UIView
@property(readonly, nonatomic) NSMutableDictionary *allSoftKeys; // @synthesize allSoftKeys=_allSoftKeys;
- (id)layoutData;
- (void)updateLayoutIfNeeded;
- (void)layoutSubviews;
- (id)getTouchedViewForTouch:(id)arg1;
- (void)softKeysDidChange;
- (void)setSoftKeyDef:(id)arg1 toViewWithId:(id)arg2;
- (id)initWithCoder:(id)arg1;
@end

@interface GKBSoftKeyboardFragmentView : GKBSoftKeyboardView
-(void)activateMeme;
@end
