#import "SecondsplashPlugin.h"
#if __has_include(<secondsplash/secondsplash-Swift.h>)
#import <secondsplash/secondsplash-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "secondsplash-Swift.h"
#endif

@implementation SecondsplashPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSecondsplashPlugin registerWithRegistrar:registrar];
}
@end
