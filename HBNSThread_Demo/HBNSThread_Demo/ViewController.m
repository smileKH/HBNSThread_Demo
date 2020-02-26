//
//  ViewController.m
//  HBNSThread_Demo
//
//  Created by Mac on 2020/2/26.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,assign)NSInteger tickets;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSThread_Demo";
    self.view.backgroundColor = [UIColor whiteColor];
   self.tickets = 20;
   NSThread *t1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTickets) object:nil];
   t1.name = @"售票员A";
   [t1 start];
   
   NSThread *t2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTickets) object:nil];
   t2.name = @"售票员B";
   [t2 start];
}
- (void)saleTickets{
    while (YES) {
        [NSThread sleepForTimeInterval:1.0];
        //互斥锁 -- 保证锁内的代码在同一时间内只有一个线程在执行
        @synchronized (self){
            //1.判断是否有票
            if (self.tickets > 0) {
                //2.如果有就卖一张
                self.tickets --;
                NSLog(@"还剩%ld张票  %@",self.tickets,[NSThread currentThread]);
            }else{
                //3.没有票了提示
                NSLog(@"卖完了 %@",[NSThread currentThread]);
                break;
            }
        }
    }

}

@end
