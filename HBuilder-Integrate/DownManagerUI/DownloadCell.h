//
//  DownloadCell.h


#import <UIKit/UIKit.h>
#import "FileModel.h"
//#import "Constants.h"
#import "MidHttpRequest.h"

@interface DownloadCell : UITableViewCell {
    FileModel *fileInfo;
    IBOutlet UIProgressView *progress1;
    IBOutlet UILabel *fileName;
    IBOutlet UILabel *fileCurrentSize;
    IBOutlet UILabel *fileSize;
    IBOutlet UIButton *operateButton;
    IBOutlet UILabel *averagebandLab;
    
}
@property(nonatomic,assign)UIViewController *delegate;
@property (retain, nonatomic) IBOutlet UILabel *fileTypeLab;
@property (retain, nonatomic) IBOutlet UILabel *courseName;
@property (retain, nonatomic) IBOutlet UIImageView *fileImage;
@property (retain, nonatomic) IBOutlet UILabel *averagebandLab;
@property (retain, nonatomic) IBOutlet UILabel *sizeinfoLab;
@property (retain, nonatomic) IBOutlet UILabel *courseDesc;

@property(nonatomic,retain)FileModel *fileInfo;
@property (retain, nonatomic) IBOutlet UIImageView *typeImage;
@property(nonatomic,retain)IBOutlet UIProgressView *progress1;
@property(nonatomic,retain)IBOutlet UILabel *fileName;
@property(nonatomic,retain)IBOutlet UILabel *fileCurrentSize;
@property(nonatomic,retain)IBOutlet UILabel *fileSize;
@property (retain, nonatomic) IBOutlet UILabel *timelable;
@property(nonatomic,retain)IBOutlet UIButton *operateButton;
@property(nonatomic,retain)MidHttpRequest *request;//该文件发起的请求
@property (retain, nonatomic)  IBOutlet UIButton *checkBtn;



- (IBAction)deleteRquest:(id)sender;

-(IBAction)operateTask:(id)sender;//操作（暂停、继续）正在下载的文件
@end
