//
//  ViewController.m
//  demo_test_textView
//
//  Created by chen liang on 2017/10/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textView.attributedText = [self convertH5StringToAttribute:@"<!DOCTYPE html>\
    <html lang=\"en\">\
    <head>\
    <meta charset=\"UTF-8\"> \
    <title>Title</title>\
    <style>\
    div {\
    color: red;\
    }\
    </style>\
                                    <style>img{width:%f !important;height:auto}</style>\
    </head>\
    <body>\
    <div>jldlfdfasfdssdfdfsfs</div>\
    <img src=\"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507802864559&di=cfdb0fbdaa4d559dc12446b69de0e12b&imgtype=0&src=http%3A%2F%2Fimg1.pconline.com.cn%2Fpiclib%2F200812%2F22%2Fbatch%2F1%2F19891%2F1229912689801kpqtgqzpxq.jpg\"\
    alt=\"\"/>\
    </body>\
    </html>"];
}

- (NSAttributedString *)convertH5StringToAttribute:(NSString *)h5String {
    
    NSAttributedString *attri = [[NSAttributedString alloc] initWithData:[h5String dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attri;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
