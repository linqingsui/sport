//
// Auto Create JsonModel File
// XSListByDateDataJsonModel.h
//
//

#import "JSONModel.h"
#import "XSMatchesItemJsonModel.h"



@interface XSListByDateDataJsonModel : JSONModel


@property (nonatomic, strong) NSArray<Optional, XSMatchesItemJsonModel> *matches;
@property (nonatomic, strong) NSString<Optional> *updateFrequency;
@property (nonatomic, strong) NSString<Optional> *today;

@end