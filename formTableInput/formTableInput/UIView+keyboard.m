//
//  UIView+keyboard.m
//  formTableInput
//
//  Created by gaojian on 2017/11/3.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import "UIView+keyboard.h"
#import <objc/message.h>

@interface JeezInputManager : NSObject

@property (weak, nonatomic) id inputView;
+ (instancetype)sharedInstance;

@end

@implementation JeezInputManager

static JeezInputManager *manager = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return manager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return manager;
}

- (void)inputViewDidBeginEditing:(NSNotification *)notification {
    
    _inputView = notification.object;
}

@end

@implementation UIView (keyboard)

+ (void)load{
    
    Method originalM = class_getInstanceMethod(self, @selector(hitTest:withEvent:));
    Method exchangeM = class_getInstanceMethod(self, @selector(kb_hitTest:withEvent:));
    method_exchangeImplementations(originalM, exchangeM);
}

- (UIView *)kb_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *hitView = [self kb_hitTest:point withEvent:event];
    if (![hitView canBecomeFirstResponder] && [[JeezInputManager sharedInstance].inputView respondsToSelector:@selector(resignFirstResponder)]) {
        
        [[JeezInputManager sharedInstance].inputView resignFirstResponder];
        [JeezInputManager sharedInstance].inputView = nil;
    }
    return hitView;
}

@end
