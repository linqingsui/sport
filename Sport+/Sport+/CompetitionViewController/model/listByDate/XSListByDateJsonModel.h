//
// Auto Create JsonModel File
// XSListByDateJsonModel.h
//
//

#import "JSONModel.h"
#import "XSListByDateDataJsonModel.h"



@interface XSListByDateJsonModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *code;

@property (nonatomic, strong) XSListByDateDataJsonModel<Optional> *data;
@property (nonatomic, strong) NSString<Optional> *version;

@end