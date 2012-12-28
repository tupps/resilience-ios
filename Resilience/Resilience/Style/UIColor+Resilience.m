
#import "UIColor+Resilience.h"


@implementation UIColor (Resilience)

+ (UIColor *)defaultTextColor {
  return [UIColor colorWithRed:(89.f/255.f) green:(89.f/255.f) blue:(89.f/255.f) alpha:1];
}

+ (UIColor *)defaultCellBackgroundColor
{
    return [UIColor colorWithRed:(233.0f/255.0f) green:(233.0f/255.0f) blue:(233.0f/255.0f) alpha:1];
}
@end