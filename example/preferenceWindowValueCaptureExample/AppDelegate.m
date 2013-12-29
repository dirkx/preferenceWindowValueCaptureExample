//
//  AppDelegate.m
//
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "AppDelegate.h"

@implementation AppDelegate

+(void)initialize {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
                                                              @"someLabel": @"een veld",
                                                              @"someCheckbox": [NSNumber numberWithBool:YES]
                                                              }];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(prefChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:[NSUserDefaults standardUserDefaults]
     ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(captureAnyPartiallyEditedPreferences:)
                                                 name:NSWindowWillCloseNotification
                                               object:self.prefWindow
     ];
}

-(IBAction)openPrefWindiw:(id)sender {
    [self.prefWindow makeKeyAndOrderFront:sender];
}

// If the user has not pressed return or tabbed outo of things
// like textfields - the bind(ing) will not update; it awaits
// an end of edit. So we force this for the while window whenever
// it closes.
//
-(void)captureAnyPartiallyEditedPreferences:(NSNotification *)notif {
    [self.prefWindow endEditingFor:nil];
}

// Show the most current values.
-(void)prefChanged:(NSNotification *)notif {
    NSLog(@"Label   : %@",
          [[NSUserDefaults standardUserDefaults] objectForKey:@"someLabel"]);
    
    NSLog(@"CheckBox: %@",
          [[[NSUserDefaults standardUserDefaults] objectForKey:@"someCheckbox"] boolValue] ?
          @"YES" : @"NO");
}
@end
