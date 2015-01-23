//
//  ActionSheetTimeRangePicker.h
//  Pods
//
//  Created by erlz nuo on 1/23/15.
//
//

#import "AbstractActionSheetPicker.h"

@class ActionSheetTimeRangePicker;

typedef void(^ActionTimeRangeDoneBlock)(ActionSheetTimeRangePicker *picker, NSInteger leftValue, NSInteger rightValue);
typedef void(^ActionTimeRangeCancelBlock)(ActionSheetTimeRangePicker *picker);

@interface ActionSheetTimeRangePicker : AbstractActionSheetPicker <UIPickerViewDelegate, UIPickerViewDataSource>

+ (instancetype)showPickerWithTitle:(NSString *)title initialLeftValue:(NSInteger)leftValue initialRightValue:(NSInteger)rightValue doneBlock:(ActionTimeRangeDoneBlock)doneBlock cancelBlock:(ActionTimeRangeCancelBlock)cancelBlockOrNil origin:(id)origin;

- (instancetype)initWithTitle:(NSString *)title initialLeftValue:(NSInteger)leftValue initialRightValue:(NSInteger)rightValue doneBlock:(ActionTimeRangeDoneBlock)doneBlock cancelBlock:(ActionTimeRangeCancelBlock)cancelBlockOrNil origin:(id)origin;

@property (nonatomic, copy) ActionTimeRangeDoneBlock onActionSheetDone;

@property (nonatomic, copy) ActionTimeRangeCancelBlock onActionSheetCancel;

@end
