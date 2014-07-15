//
//  SDViewController.h
//  SwitchDemo
//
//  Created by Tarun Tyagi on 14/07/14.
//  Copyright (c) 2014 Tarun Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* demoTblVw;
}

@end
