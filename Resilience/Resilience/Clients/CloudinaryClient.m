
#import "CloudinaryClient.h"

@interface CloudinaryClient()

@property (nonatomic, strong) CLUploader *uploader;
@property (nonatomic, copy) UploadSuccessBlock uploadSuccessBlock;
@property (nonatomic, copy) FailureBlock uploadFailureBlock;

@end

@implementation CloudinaryClient

- (id)init {
  if (self = [super init]) {
    CLCloudinary *cloudinary = [[CLCloudinary alloc] init];
    [cloudinary.config setValue:@"resilience" forKey:@"cloud_name"];
    [cloudinary.config setValue:@"345754584192129" forKey:@"api_key"];
    [cloudinary.config setValue:@"EOqrfFTaj1vNv_3BTTUAWCQgGUc" forKey:@"api_secret"];
    self.uploader = [[CLUploader alloc] init:cloudinary delegate:self];
  }
  return self;
}

+ (void)updloadImage:(UIImage *)image success:(UploadSuccessBlock)success failure:(FailureBlock)failure {
  CloudinaryClient *client = [[CloudinaryClient alloc] init];
  [client.uploader upload:UIImageJPEGRepresentation(image, 0.75f) options:@{}];
  client.uploadSuccessBlock = success;
  client.uploadFailureBlock = failure;
}

#pragma mark - CLUploaderDelegate
- (void) uploaderSuccess:(NSDictionary*)result context:(id)context {
  NSString* publicId = [result valueForKey:@"public_id"];
  NSLog(@"Upload success. Public ID=%@, Full result=%@", publicId, result);
  self.uploadSuccessBlock([result valueForKey:@"url"]);
}

- (void) uploaderError:(NSString*)result code:(int) code context:(id)context {
  NSLog(@"Upload error: %@, %d", result, code);
  self.uploadFailureBlock([NSError errorWithDomain:@"upload" code:code userInfo:@{ @"result": result }]);
}

- (void) uploaderProgress:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite context:(id)context {
  NSLog(@"Upload progress: %d/%d (+%d)", totalBytesWritten, totalBytesExpectedToWrite, bytesWritten);
}
@end