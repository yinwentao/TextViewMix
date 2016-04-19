//
//  ViewController.m
//  TextViewMix
//
//  Created by 尹文涛 on 15/11/2.
//  Copyright (c) 2015年 文涛工作室. All rights reserved.
//

#import "ViewController.h"

NSString * str = @"asfasfa阿斯顿发生大发撒放大离开家撒旦法按时付款就阿里；双方均asfasdfasfdalkjsflakj阿斯顿发生大发撒旦法asdfasdfaasfdaasa撒旦法；拉斯克奖发了奥斯卡奖罚洛杉矶的法律；看见谁发的阿斯利康就发；了数据库等法律按实际开发；阿里就开始放到了；安家费阿里山科技发达了开始将对方拉开始交电费了卡双方的空间啊发送卡飞机阿里开始就放暑假了罚款就是浪费";

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

/*
 TextKit是iOS7新推出的文字排版技术，使用TextKit可以很方便的实现富文本、表情混排和图文混排等效果。TextKit中的几个关键的类：
 
 NSAttributeString和NSMutableAttributeString：属性字符串和可变属性字符串，这个TextKit中最基础的类，文字中的所有富文本属性都是通过属性字符串来表现出来的
 NSTextAttachment：字符串的附件，将图片，可以将图片等内容当做一个附件插入到属性字符串中，可以实现表情混排，链接等效果
 
 参考：http://blog.csdn.net/liujinlongxa/article/details/44840753
 
 */
    
    self.textView.text = str;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.editable = NO;
    self.textView.delegate = self;
    
    // 设置常规属性
    [self setupNormalAttribute];
    
    // 链接和表情
    [self setupEmojiAndLink];
    
    // 图文混排，设置图片的位置
    [self setupImageAround];
    
}

/**
 *  向文本中添加表情，链接等
 */
- (void)setupEmojiAndLink
{
    NSMutableAttributedString *mutStr = [self.textView.attributedText mutableCopy];
    
    // 添加表情
    UIImage *image1 = [UIImage imageNamed:@"080"];
    NSTextAttachment *attachment1 = [[NSTextAttachment alloc] init];
    attachment1.bounds = CGRectMake(0, 0, 30, 30);
    attachment1.image = image1;
    NSAttributedString *attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
    [mutStr insertAttributedString:attachStr1 atIndex:30];
    
    //添加表情
    UIImage *image2 = [UIImage imageNamed:@"084"];
    NSTextAttachment *attachment2 = [[NSTextAttachment alloc] init];
    attachment2.bounds = CGRectMake(0, 0, 15, 15);
    attachment2.image = image2;
    NSAttributedString *attachStr2 = [NSAttributedString attributedStringWithAttachment:attachment2];
    [mutStr insertAttributedString:attachStr2 atIndex:100];
    
    
    //添加链接
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    [mutStr addAttribute:NSLinkAttributeName value:url range:NSMakeRange(70, 10)];
    
    self.textView.attributedText = mutStr;
}

/**
 *  设置常规属性
 */
- (void)setupNormalAttribute
{
    NSMutableAttributedString * mutStr = [self.textView.attributedText mutableCopy];
    
    //颜色
    [mutStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 10)];
    //字体
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(20, 5)];
    //下划线
    [mutStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternDot) range:NSMakeRange(32, 8)];
    //空心字
    [mutStr addAttribute:NSStrokeWidthAttributeName value:@(2) range:NSMakeRange(42, 5)];
    
    //背景色
    [mutStr addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(47, 10)];
    
    self.textView.attributedText = [mutStr copy];
}

/**
 *  图文混排，设置图片的位置
 */
- (void)setupImageAround{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    imageView.image = [UIImage imageNamed:@"2.jpg"];
    imageView.backgroundColor = [UIColor redColor];
    [self.textView addSubview:imageView];
    
    CGRect rect = CGRectMake(0, 0, 110, 100);

    /* 设置环绕的路径
        textview 就会把rect的范围空出来
        textContainer 有时间 再研究一下
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    self.textView.textContainer.exclusionPaths = @[path];

}

/**
 *  点击图片触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    return YES;
}

/**
 *  点击链接，触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"点击了：%@",URL);
    
    
//    [[UIApplication sharedApplication] openURL:URL];
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
