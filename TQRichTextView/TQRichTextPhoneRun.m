//
//  TQRichTextPhoneRun.m
//  TQRichTextViewDemo
//
//  Created by apple on 14-4-25.
//  Copyright (c) 2014年 fuqiang. All rights reserved.
//

#import "TQRichTextPhoneRun.h"

@implementation TQRichTextPhoneRun
-(id)init
{
    self = [super init];
    if (self) {
        self.type = richTextPhoneType;
        self.isResponseTouch = YES;
    }
    return self;
}

//-- 替换基础文本
- (void)replaceTextWithAttributedString:(NSMutableAttributedString*) attributedString
{
    [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor blueColor].CGColor range:self.range];
    [super replaceTextWithAttributedString:attributedString];
}

//-- 绘制内容
- (BOOL)drawRunWithRect:(CGRect)rect
{
    return NO;
}

//-- 解析文本内容
+ (NSString *)analyzeText:(NSString *)string runsArray:(NSMutableArray **)runArray
{
    //((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
    NSError *error;
    //NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    // NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSString * regulaStr= @"(18[0-9]{9})|(13[0-9]{9})|(15[0-9]{9})";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [string substringWithRange:match.range];
        TQRichTextPhoneRun *urlRun = [[TQRichTextPhoneRun alloc] init];
        urlRun.range = match.range;
        urlRun.originalText = substringForMatch;
        
        [*runArray addObject:urlRun];
    }
    
    return [string copy];
}

@end
