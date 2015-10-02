//
//  AddTaskViewController.m
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addTaskTextView.delegate=self;
    self.addTaskLabel.delegate=self;
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

//First it has to be created a method to make a task before implemente the method didAddTask to the button action

-(Task *) returnNewTask{
    
    Task *taskObject = [[Task alloc] init];
    
    taskObject.title = self.addTaskLabel.text;
    taskObject.taskdescription = self.addTaskTextView.text;
    taskObject.date = self.addTaskDatePicker.date;
    taskObject.isCompleted = NO;
    
    return taskObject;
    

}

- (IBAction)addTaskButton:(UIButton *)sender {
    
    [self.delegate didAddTask:[self  returnNewTask]];
}

- (IBAction)cancelTaskButton:(UIButton *)sender {
  
    [self.delegate didCancel];
    
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.addTaskLabel resignFirstResponder];
    return YES;

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.addTaskTextView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
