//
//  RootVC.m
//  BWFFMDB
//
//  Created by BWF-HHW on 16/6/17.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import "RootVC.h"
#import "Singleton.h"
#import "Model.h"


@interface RootVC ()

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [[Singleton shareSingleTon] insertDBWithName:@"nihao" Age:12 ID:1];

}
- (IBAction)insert:(id)sender {
    
   NSInteger ID = arc4random() % 10000;
    [[Singleton shareSingleTon] insertDBWithName:@"nihao" Age:12 ID:ID];
}

- (IBAction)delete:(id)sender {
    
    [[Singleton shareSingleTon] deleteAllData];
}

- (IBAction)deleteFromID:(id)sender {
    
    [[Singleton shareSingleTon] deleteWithID:1];
}

- (IBAction)update:(id)sender {
    [[Singleton shareSingleTon] updateTBWithID:1 name:@"aaaaaaaaaa"];
}



- (IBAction)getArray:(id)sender {
    
    
   NSMutableArray *array = [[Singleton shareSingleTon] getModelFromFMDB];
    for (Model *model in array) {
        NSLog(@"数据库中模型----%@", model.name);
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

@end
