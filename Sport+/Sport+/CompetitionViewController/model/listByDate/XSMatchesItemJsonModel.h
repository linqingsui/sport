//
// Auto Create JsonModel File
// XSMatchesItemJsonModel.h
//
//

#import "JSONModel.h"

@protocol XSMatchesItemJsonModel

@end
#import "XSMatchInfoJsonModel.h"



@interface XSMatchesItemJsonModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *updateFrequency;

@property (nonatomic, strong) XSMatchInfoJsonModel<Optional> *matchInfo;

@end