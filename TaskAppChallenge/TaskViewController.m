//
//  TaskViewController.m
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "TaskViewController.h"



@interface TaskViewController ()

@end

@implementation TaskViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.infoTaskLabel.text = self.task.title;
    self.info1TaskLabel.text = self.task.taskdescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    
    self.info2TaskLabel.text =stringFromDate;
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]){
        EditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.task;
        editTaskViewController.delegate = self;
        
    }
    
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

- (IBAction)editTask:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:nil];
}

-(void)didUpdateTask{
    self.infoTaskLabel.text = self.task.title;
    self.info2TaskLabel.text = self.task.taskdescription;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.info2TaskLabel.text =stringFromDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTask];
}

@end
