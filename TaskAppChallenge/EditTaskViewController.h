//
//  EditTaskViewController.h
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTaskViewController : UIViewController
- (IBAction)saveEditedTaskButton:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *editedTaskLabel;
@property (strong, nonatomic) IBOutlet UITextView *editedTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *editedDatePicker;

@end
