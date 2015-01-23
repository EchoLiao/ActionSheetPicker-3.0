//
//  ActionSheetTimeRangePicker.m
//  Pods
//
//  Created by erlz nuo on 1/23/15.
//
//

#import "ActionSheetTimeRangePicker.h"

@implementation ActionSheetTimeRangePicker
{
    NSInteger   leftValue;
    NSInteger   rightValue;
}

+ (instancetype)showPickerWithTitle:(NSString *)title initialLeftValue:(NSInteger)lValue initialRightValue:(NSInteger)rValue doneBlock:(ActionTimeRangeDoneBlock)doneBlock cancelBlock:(ActionTimeRangeCancelBlock)cancelBlockOrNil origin:(id)origin
{
    ActionSheetTimeRangePicker * picker = [[self alloc] initWithTitle:title initialLeftValue:lValue initialRightValue:rValue doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (instancetype)initWithTitle:(NSString *)title initialLeftValue:(NSInteger)lValue initialRightValue:(NSInteger)rValue doneBlock:(ActionTimeRangeDoneBlock)doneBlock cancelBlock:(ActionTimeRangeCancelBlock)cancelBlockOrNil origin:(id)origin
{
    self = [super initWithTarget:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        self.title = title;
        leftValue  = lValue;
        rightValue = rValue;
        self.onActionSheetDone   = doneBlock;
        self.onActionSheetCancel = cancelBlockOrNil;
    }
    return self;
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
    return 3 + 1 + 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    return (component == 0 || component == 3) ? 5 : 60;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    if (component == 3) {
        return @"-";
    } else {
        return [NSString stringWithFormat:@"%ld", (long)row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat aix = pickerView.frame.size.width / 7;
    return component == 3 ? aix * 0.8 : aix;
}

@end
