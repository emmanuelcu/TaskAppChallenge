//
//  EditTaskViewController.m
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.editedTaskLabel.text = self.task.title;
    self.editedTextView.text = self.task.taskdescription;
    self.editedDatePicker.date = self.task.date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveEditedTaskButton:(UIBarButtonItem *)sender {
    
    [self updateTask];
    [self.delegate didUpdateTask];
}

-(void)updateTask{
    self.task.title = self.editedTaskLabel.text;
    self.task.taskdescription = self.editedTextView.text;
    self.task.date = self.editedDatePicker.date;
}
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.editedTaskLabel resignFirstResponder];
    return YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.editedTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
