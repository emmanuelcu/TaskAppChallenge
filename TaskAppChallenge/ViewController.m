//
//  ViewController.m
//  TaskAppChallenge
//
//  Created by Emmanuel Cuevas on 9/19/15.
//  Copyright © 2015 Emmanuel Cuevas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//Lazy insitation to initiate an array. It must be a mutable array because we are going to be adding and removing tasks as our users adds and deletes them.

-(NSMutableArray *) taskObjects{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
        
    }
    return _taskObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *taskAsPropertyLists =[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY];
    for (NSDictionary *dictionary in taskAsPropertyLists){
        Task *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
}


//Method to prepare the information to pass it to the addtask view controller
#pragma mark - Prepare for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskViewControllerObject = segue.destinationViewController;
        addTaskViewControllerObject.delegate=self;
    }
    else if ([segue.destinationViewController isKindOfClass: [TaskViewController class]]){
        TaskViewController *taskViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        Task *taskObject = self.taskObjects[path.row];
        taskViewController.task =taskObject;
        taskViewController.delegate = self;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderTaskButton:(UIBarButtonItem *)sender {
    
    if(self.tableView.editing==YES) [self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
}

- (IBAction)addTaskButtonVC:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:nil];
}

#pragma mark - AddTaskViewControllerDelegate

-(void)didAddTask:(Task *)task{
    
    [self.taskObjects addObject:task];
    NSLog(@"%@", task.title);

    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    //Creating the methos before finishing this task to property list
    
    [taskObjectsAsPropertyLists addObject: [self taskObjectsAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


-(void)didCancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - TaskViewControllerDelegate

-(void)updateTask{
    [self saveTasks];
    [self.tableView reloadData];

}

#pragma mark - Helper methods
    
    -(NSDictionary *)taskObjectsAsPropertyList:(Task *) taskObject{
    
        NSDictionary *dictionary = @{
                                     TASK_TITLE : taskObject.title,
                                     TASK_DESCRIPTION : taskObject.description,
                                     TASK_DATE : taskObject.date,
                                     TASK_COMPLETION : @(taskObject.isCompleted)
                                     };
        return dictionary;
    
    }

-(Task *)taskObjectForDictionary :(NSDictionary *)dictionary{
    
    Task *taskObject = [[Task alloc] initWithData:dictionary];
    return taskObject;

}

-(BOOL)isDateGreaterThanDate: (NSDate *)date and:(NSDate *)toDate{

    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval>toDateInterval) return YES;
    else return NO;

}

-(void)updateCompletionOfTask:(Task *)task forIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectsAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];

}

-(void)saveTasks{
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0 ; x < [self.taskObjects count]; x++){
        [taskObjectsAsPropertyLists addObject:[self taskObjectsAsPropertyList:self.taskObjects[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - UITAbleViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.taskObjects count];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Task *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    //configuring the color of the cell depending on the date
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    
    if (task.isCompleted==YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverDue==YES) cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:11/255.0 blue:0/255.0 alpha:1];
    else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;

}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Task *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //Delete the row from the data source
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newTaskObjectData = [[NSMutableArray alloc] init];
        for (Task *taskObject in self.taskObjects){
            [newTaskObjectData addObject:[self taskObjectsAsPropertyList:taskObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectData forKey:TASK_OBJECT_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toTaskViewController" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Task *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    [self saveTasks];
}
@end
