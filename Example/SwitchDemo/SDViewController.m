//
//  SDViewController.m
//  SwitchDemo
//
//  Created by Tarun Tyagi on 14/07/14.
//  Copyright (c) 2014 Tarun Tyagi. All rights reserved.
//

#import "SDViewController.h"
#import "Switch.h"

#define Scale [UIScreen mainScreen].scale

@interface SDViewController ()

@end

@implementation SDViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
	
    demoTblVw = [[UITableView alloc] initWithFrame:self.view.frame
                                             style:UITableViewStylePlain];
    demoTblVw.backgroundColor = [UIColor clearColor];
    demoTblVw.dataSource = self;
    demoTblVw.delegate = self;
    [self.view addSubview:demoTblVw];
}

-(void)switchToggled:(Switch*)mySwitch
{
    UITableViewCell* cell = (UITableViewCell*)mySwitch.superview.superview.superview;
    NSIndexPath* indexPath = [demoTblVw indexPathForCell:cell];
    NSLog(@"Switch %d Toggled %@", indexPath.row, (mySwitch.on ? @"ON" : @"OFF"));
}

#pragma mark
#pragma mark<UITableViewDataSource Methods>
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* cellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Decide Switch's image, each time it needs to be reset, we're dequeuing cells
    NSString* imgNameStr = [NSString stringWithFormat:@"switch%d.png",indexPath.row];
    UIImage* image = [UIImage imageNamed:imgNameStr];
    
    // Same is the case for visibleWidth
    CGFloat widthPortionFactor = 0.67f;
    if(indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 9)
        widthPortionFactor = 0.62f;
    
    Switch* mySwitch = nil;
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
        
        mySwitch = [Switch switchWithImage:image
                              visibleWidth:(image.size.width/Scale)*widthPortionFactor];
        [mySwitch addTarget:self action:@selector(switchToggled:)
           forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:mySwitch];
        mySwitch.tag = 12345;
    }
    else
    {
        mySwitch = (Switch*)[cell.contentView viewWithTag:12345];
    }
    
    // Update the switch image, visibleWidth & origin accordingly
    mySwitch.image = image;
    mySwitch.visibleWidth = (image.size.width/Scale)*widthPortionFactor;
    mySwitch.origin = CGPointMake((320 - mySwitch.visibleWidth)/2,
                                  (90 - mySwitch.frame.size.height)/2);
    
    // Adjust cornerRadius as needed 'roundedCornerStyle' switch or other
    if(indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 ||
       indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9)
    {
        mySwitch.layer.cornerRadius = (image.size.height/Scale)/2;
    }
    else
    {
        mySwitch.layer.cornerRadius = 5.0f;
    }
    
    /*
     * Add any border as needed to compensate image
     * Uncomment following lines to see what happens
     */
    if(indexPath.row == 0 || indexPath.row == 7)
    {
        mySwitch.layer.borderWidth = (indexPath.row == 0) ? 7.0f : 3.0f;
        mySwitch.layer.borderColor = [UIColor blackColor].CGColor;
    }
    else
    {
        mySwitch.layer.borderWidth = 0.0f;
    }
    
    return cell;
}

#pragma mark
#pragma mark<UITableViewDelegate Methods>
#pragma mark

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 90;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
