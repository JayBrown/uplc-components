// uplcd.m
// v0.1.0

#import <Cocoa/Cocoa.h>
#import <stdio.h>
#include <signal.h>

@interface uplcd: NSObject {}
-(id) init;
-(void) mountedVolume: (NSNotification*) notification;
@end

@implementation uplcd
-(id) init {
  NSNotificationCenter * notify
    = [[NSWorkspace sharedWorkspace] notificationCenter];

  [notify addObserver: self
          selector:    @selector(mountedVolume:)
          name:        @"NSWorkspaceDidMountNotification"
          object:      nil
  ];
  fprintf(stderr,"Listening...\n");
  [[NSRunLoop currentRunLoop] run];
  fprintf(stderr,"Stopping...\n");
  return self;
}

-(void) mountedVolume: (NSNotification*) notification {
  NSDictionary *userInfo = [notification userInfo];
  NSString* VolumePath = [userInfo objectForKey:@"NSDevicePath"];
  // NSString* VolumeName = [userInfo objectForKey:@"NSWorkspaceVolumeLocalizedNameKey"];
  // NSLog(@":::%@:::%@", VolumePath, VolumeName);
  NSLog(@"%@", VolumePath);
}
@end

int main( int argc, char ** argv) {
  [[uplcd alloc] init];
  return 0;
}

// build: gcc -Wall uplcd.m -o uplcd -lobjc -framework Cocoa
// run: ./uplcd
