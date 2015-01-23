//
//  ActionSheetTimeRangePicker.m
//  Pods
//
//  Created by erlz nuo on 1/23/15.
//
//

#import "ActionSheetTimeRangePicker.h"

#define kComponentCount (3 + 1 + 3)

@implementation ActionSheetTimeRangePicker
{
    NSInteger   values[kComponentCount];
}

+ (instancetype)showPickerWithTitle:(NSString *)title initialLeftValue:(NSInteger)lValue initialRightValue:(NSInteger)rValue doneBlock:(ActionTimeRangeDoneBlock)doneBlock cancelBlock:(ActionTimeRangeCancelBlock)cancelBlockOrNil origin:(id)origin
{
    ActionSheetTimeRangePicker * picker = [[self alloc] initWithTitle:title initialLeftValue:lValue initialRightValue:rValue doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (instancetype)initWithTitle:(NSString *)title initialLeftValue:(NSInteger)lValue initialRightValue:(NSInteger)rValue doneBlock:(ActionTimeRangeDoneBlock)doneBlock cancelBlock:(ActionTimeRangeCancelBlock)cancelBlockOrNil origin:(id)origin
{
    NSAssert(lValue < 5 * 3600 && rValue < 5 * 3600, @"");
    self = [super initWithTarget:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        self.title = title;
        values[0] = lValue / 3600;
        values[1] = (lValue - values[0] * 3600) / 60;
        values[2] = (lValue - values[0] * 3600 - values[1] * 60);
        values[4] = rValue / 3600;
        values[5] = (rValue - values[4] * 3600) / 60;
        values[6] = (rValue - values[4] * 3600 - values[5] * 60);
        self.onActionSheetDone   = doneBlock;
        self.onActionSheetCancel = cancelBlockOrNil;
    }
    return self;
}

#pragma mark -

- (UIView *)configuredPickerView
{
    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:pickerFrame];

    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    picker.userInteractionEnabled = YES;

    for (int i = 0; i < kComponentCount; i++) {
        [picker selectRow:values[i] inComponent:i animated:NO];
    }

    self.pickerView = picker;

    return picker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin
{
    if (self.onActionSheetDone) {
        self.onActionSheetDone(self, values[0]*3600 + values[1]*60 + values[2], values[4]*3600 + values[5]*60 + values[6]);
    }
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin
{
    if (self.onActionSheetCancel) {
        self.onActionSheetCancel(self);
    }
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    values[component] = row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return kComponentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component == 3 ? 1 : ((component == 0 || component == 4) ? 5 : 60);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return component == 3 ? @"-" : [NSString stringWithFormat:@"%02ld", (long)row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return (pickerView.frame.size.width - 40) / kComponentCount;
}

@end
