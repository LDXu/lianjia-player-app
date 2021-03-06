//
//  DownloadViewController.m


#import "DownloadViewController.h"
#import "FilesDownManage.h"
#import "AppDelegate.h"
#import "MoviePlayerViewController.h"
#import "HaveDownloadViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#define OPENFINISHLISTVIEW
#define TEMPPATH [CommonHelper getTempFolderPathWithBasepath:@"DownLoad"]

@implementation DownloadViewController

@synthesize downloadingTable;
@synthesize finishedTable;
@synthesize downingList;
@synthesize finishedList;
@synthesize editBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)goDownloadingView:(UIButton *)sender {
    if (downloadingTable.hidden == NO) {
        return;
    }
    
    downloadingTable.hidden = NO;
    finishedTable.hidden =YES;
    //_editbtn.hidden = YES;
    
    
//    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
    
    [self.downloadingViewBtn setBackgroundColor:[UIColor colorWithRed:198/255.0f green:235/255.0f blue:215/255.0f alpha:1.0f]];
    [self.finieshedViewBtn setBackgroundColor:[UIColor whiteColor]];

    [self.downloadingViewBtn setTitleColor:[UIColor colorWithRed:31/255.0f green:154/255.0f blue:87/255.0f alpha:1.0f] forState:UIControlStateNormal];

   [self.finieshedViewBtn setTitleColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [self.downloadingTable reloadData];
    
    if ([self.downingSetEditModeFlag isEqualToString:@"0"]&&self.navigationItem.rightBarButtonItem.tag == 99) {
        self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y + 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
        
        self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  + 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
        
        self.cancelBtn.hidden = YES;
        self.deleteOKBtn.hidden = YES;
    } else   if ([self.downingSetEditModeFlag isEqualToString:@"1"]&&self.navigationItem.rightBarButtonItem.tag == 0) {
        self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y - 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
        
        self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  - 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
        self.cancelBtn.hidden = NO;
        self.deleteOKBtn.hidden = NO;
        
    }
    
    [_deleteOKBtn setTitle:[NSString stringWithFormat:@"删除(%d)",[self.downingSelectList count]] forState:UIControlStateNormal];

//    _diskInfoLab.hidden = YES;
//    _diskInfoLab1.hidden = YES;
    
    
}

- (IBAction)goFinishedView:(UIButton *)sender {
    
    if (finishedTable.hidden == NO) {
        return;
    }
    downloadingTable.hidden = YES;
    finishedTable.hidden =NO;
//    self.navigationItem.rightBarButtonItem.customView.hidden=NO;
    
    [self.finieshedViewBtn setBackgroundColor:[UIColor colorWithRed:198/255.0f green:235/255.0f blue:215/255.0f alpha:1.0f]];
    [self.downloadingViewBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.finieshedViewBtn setTitleColor:[UIColor colorWithRed:31/255.0f green:154/255.0f blue:87/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [self.downloadingViewBtn setTitleColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f] forState:UIControlStateNormal];

    [self.finishedTable reloadData];
    
    if ([self.downingSetEditModeFlag isEqualToString:@"1"]&&self.navigationItem.rightBarButtonItem.tag == 0) {
        self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y + 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
        
        self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  + 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
        self.cancelBtn.hidden = YES;
        self.deleteOKBtn.hidden = YES;

    }else  if ([self.downingSetEditModeFlag isEqualToString:@"0"]&&self.navigationItem.rightBarButtonItem.tag == 99) {
        self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y - 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
        
        self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  - 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
        
        self.cancelBtn.hidden = NO;
        self.deleteOKBtn.hidden = NO;
    }
    

    [_deleteOKBtn setTitle:[NSString stringWithFormat:@"删除(%d)",[self.downloadSelectList count]] forState:UIControlStateNormal];
    
    
    

}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showFinished
{
    [self startFlipAnimation:0];
    self.navigationItem.rightBarButtonItem= [self makeCustomRightBarButItem:@"下载中" action:@selector(showDowning)];
}

-(void)showDowning
{
    [self startFlipAnimation:1];
    self.navigationItem.rightBarButtonItem=[self makeCustomRightBarButItem:@"已下载" action:@selector(showFinished)];
}


-(void)startFlipAnimation:(NSInteger)type
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    UIView *lastView=[self.view viewWithTag:103];
    
    if(type==0)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:lastView cache:YES];
    }
    else
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:lastView cache:YES];
    }
    
    UITableView *frontTableView=(UITableView *)[lastView viewWithTag:101];
    UITableView *backTableView=(UITableView *)[lastView viewWithTag:102];
    NSInteger frontIndex=[lastView.subviews indexOfObject:frontTableView];
    NSInteger backIndex=[lastView.subviews indexOfObject:backTableView];
    [lastView exchangeSubviewAtIndex:frontIndex withSubviewAtIndex:backIndex];
    [UIView commitAnimations];
}




-(IBAction)clearlist:(UIButton *)sender{
    if ([self.finishedList count]==0)
        return;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"删除已完成列表的所有内容，将不会删除对应的文件，确认删除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    return;
}
-(void)clearAction{
    if (!self.downloadingTable.hidden) {
        if ([self.downingList count]>0) {
            FilesDownManage *filedownmanage = [FilesDownManage sharedFilesDownManage];
            [filedownmanage clearAllRquests];
            [self.downingList removeAllObjects];
            [self.downloadingTable reloadData];
        }
    }else if (!self.finishedTable.hidden){
        if ([self.finishedList count]>0) {
            FilesDownManage *filedownmanage = [FilesDownManage sharedFilesDownManage];
            [filedownmanage clearAllFinished];
            [self.finishedList removeAllObjects];
            [self.finishedTable reloadData];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self clearAction];
    }
}
#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{

    // self.navigationController.navigationBar.hidden = YES;
    FilesDownManage *filedownmanage = [FilesDownManage sharedFilesDownManage];
    
    [filedownmanage startLoad];
    self.downingList =[FilesDownManage sharedFilesDownManage].downinglist;
    
    [FilesDownManage sharedFilesDownManage].downloadDelegate = self;

    
//    //按照章节号进行排序
//    NSComparator cmptr1 = ^(id obj1, id obj2){
//        
//        MidHttpRequest *request1 = (MidHttpRequest *)obj1;
//        MidHttpRequest *request2 = (MidHttpRequest *)obj2;
//
//        FileModel *fileInfo1 =  [request1.userInfo objectForKey:@"File"];
//        FileModel *fileInfo2 =  [request2.userInfo objectForKey:@"File"];
//
//
//        NSString *id1 = fileInfo1.chapterId;
//        NSString *id2 = fileInfo2.chapterId;
//        
//        
//        if ([id1 integerValue] > [id2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        
//        if ([id1 integerValue] < [id2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    };
//    [[FilesDownManage sharedFilesDownManage].downinglist sortUsingComparator:cmptr1];

    

    [self.downloadingTable reloadData];
    
    
    //按照章节号进行排序
    
    [[FilesDownManage sharedFilesDownManage] loadFinishedfiles];
    self.finishedList=[FilesDownManage sharedFilesDownManage].finishedlist;
    
    if ([self.finishedList count] == 0) {
        [self showAllTextDialog:@"暂无下载完成的文件"];
    }
    
    long totalDownloadSize = 0;
    
    for (int i = 0 ; i < [self.finishedList count]; i ++) {
        NSDictionary *lineDict = [self.finishedList objectAtIndex:i];
        NSString *totalSize = [lineDict objectForKey:@"TOTAL_SIZE"];
        int size = totalSize.intValue;
        totalDownloadSize += size;
    }
    
    self.diskInfoLab.text = [NSString stringWithFormat:@"已下载%.2fG",totalDownloadSize/1024.0f/1024.0f/1024.0f];
    
    
    NSComparator cmptr = ^(id obj1, id obj2){
        NSDictionary *dict1 = (NSDictionary*)obj1;
        NSDictionary *dict2 = (NSDictionary*)obj2;

        NSString *id1 = [dict1 objectForKey:@"ID"];
        NSString *id2 = [dict2 objectForKey:@"ID"];

        
        if ([id1 integerValue] > [id2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([id1 integerValue] < [id2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    [self.finishedList sortUsingComparator:cmptr];
    
    [self.finishedTable reloadData];
    
    
    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
    //reach.reachableOnWWAN = NO;
    
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDownloadingTable) name:@"refreshDowndingTable" object:nil];
    

}
//刷新正在下载的table
-(void)refreshDownloadingTable{
    self.downingList =[FilesDownManage sharedFilesDownManage].downinglist;
    [self.downloadingTable reloadData];

}
-(void)viewWillDisappear:(BOOL)animated{
    // self.navigationController.navigationBar.hidden = NO;
//    FilesDownManage *filedownmanage = [FilesDownManage sharedFilesDownManage];
//    [filedownmanage saveFinishedFile];
    [FilesDownManage sharedFilesDownManage].downloadDelegate = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshDowndingTable" object:nil];
    
}
- (void)viewDidLoad
{
    self.title = @"下载";
    [super viewDidLoad];
 
     version =[[[UIDevice currentDevice] systemVersion] floatValue];
    
    [FilesDownManage sharedFilesDownManage].downloadDelegate = self;

    downloadingTable.hidden = YES;
    finishedTable.hidden =NO;

    clearallbtn.hidden = YES;
    

    self.diskInfoLab1.text = [CommonHelper getDiskSpaceInfo];

    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [rightButton addTarget:self action:@selector(setDeleteMode) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_delete_d.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    rightBtn.tag = 0;
    self.navigationItem.rightBarButtonItem = rightBtn;

//    editBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(setEditMode)];
//    editBtn.tag = 999;//可以编辑
    //self.navigationItem.rightBarButtonItem = editBtn;
    
    //UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goback)];
    
    
//    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    
//    [backButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
//    
//    //[backButton setBackgroundImage:[UIImage imageNamed:@"leftarrow.png"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"lrtico.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    
////    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftarrow.png"] style:UIBarButtonItemStylePlain target:self
////                                   action:@selector(goback)];
//    
//    
//    
//    self.navigationItem.leftBarButtonItem = backBtn;
    
    
    
    UIImage *backImg = [UIImage imageNamed:@"lrtico.png"];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, backImg.size.width/2, backImg.size.height/2)];
    
    
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn setImage:backImg forState:UIControlStateNormal];
    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, -6, 0);
    [backBtnView addSubview:backBtn];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    self.navigationItem.leftBarButtonItem = backBarBtn;


    [self.finishedTable       setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self.downloadingTable       setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    
//    self.finishedTable.backgroundColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f];
//    self.downloadingTable.backgroundColor = [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f];
    
//    self.finishedTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.downloadingTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

   finishedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    downloadingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.finieshedViewBtn setBackgroundColor:[UIColor colorWithRed:198/255.0f green:235/255.0f blue:215/255.0f alpha:1.0f]];
    [self.downloadingViewBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.finieshedViewBtn setTitleColor:[UIColor colorWithRed:31/255.0f green:154/255.0f blue:87/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [self.downloadingViewBtn setTitleColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    self.downloadSelectList = [NSMutableArray array];
    
    self.downingSelectList = [NSMutableArray array];
    
    NSLog(@"x = %.2f",self.diskInfoLab1.frame.origin.x);
    NSLog(@"y = %.2f",self.diskInfoLab1.frame.origin.y);
    
    
    self.downingSetEditModeFlag = @"0";

}
-(void)setDeleteMode{
    if (self.navigationItem.rightBarButtonItem.tag == 0 &&finishedTable.hidden == NO) {//已经下载完成的表格
        [UIView animateWithDuration:.1 animations:^{
            
            for (NSIndexPath* i in [finishedTable indexPathsForVisibleRows])
            {
                FinishedCell *cell = [finishedTable cellForRowAtIndexPath:i];
                
                if ([self.downloadSelectList containsObject:i]) {
                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                }else{
                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
                }
                
                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x + 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x + 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
                cell.finishCountLabel.frame =CGRectMake(cell.finishCountLabel.frame.origin.x + 25, cell.finishCountLabel.frame.origin.y, cell.finishCountLabel.frame.size.width, cell.finishCountLabel.frame.size.height);
                cell.fileSize.frame = CGRectMake(cell.fileSize.frame.origin.x + 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
                cell.checkBtn.hidden = NO;
                [cell bringSubviewToFront:cell.checkBtn];

                
            }
            
            _cancelBtn.hidden = NO;
            _deleteOKBtn.hidden = NO;
            [_deleteOKBtn setTitle:[NSString stringWithFormat:@"删除(%d)",[self.downloadSelectList count]] forState:UIControlStateNormal];
            self.navigationItem.rightBarButtonItem.tag = 99;
            

            self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x,self.diskInfoLab1.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
            
            self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);

            
            
            
        } completion:^(BOOL finished){

        }];
    }else if(finishedTable.hidden == YES ){
        if ([@"0" isEqualToString:self.downingSetEditModeFlag]) {//转为可勾选状态。
            [UIView animateWithDuration:.1 animations:^{
                
            for (NSIndexPath* i in [downloadingTable indexPathsForVisibleRows])
            {
                DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:i];
                
                if ([self.downingSelectList containsObject:i]) {
                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                }else{
                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
                }
                
                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x + 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x + 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);

                cell.courseDesc.frame = CGRectMake(cell.courseDesc.frame.origin.x + 25, cell.courseDesc.frame.origin.y, cell.courseDesc.frame.size.width, cell.courseDesc.frame.size.height);
                cell.checkBtn.hidden = NO;
                [cell bringSubviewToFront:cell.checkBtn];
                
            }
                
                self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x,self.diskInfoLab1.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
                
                self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
                    


                
            _cancelBtn.hidden = NO;
            _deleteOKBtn.hidden = NO;
                
            [_deleteOKBtn setTitle:[NSString stringWithFormat:@"删除(%d)",[self.downingSelectList count]] forState:UIControlStateNormal];
                
            } completion:^(BOOL finished){
                self.downingSetEditModeFlag = @"1";
            }];

            
            
            
//        }else{
//            [UIView animateWithDuration:.1 animations:^{
//                
//                for (NSIndexPath* i in [downloadingTable indexPathsForVisibleRows])
//                {
//                    DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:i];
//                    
//                    if ([self.downingSelectList containsObject:i]) {
//                        [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
//                    }else{
//                        [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
//                    }
//                    
//                    
//                    cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x + 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
//                    cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x + 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
//                    
//                    cell.courseDesc.frame = CGRectMake(cell.fileSize.frame.origin.x + 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
//                    cell.checkBtn.hidden = NO;
//                    [cell bringSubviewToFront:cell.checkBtn];
//                    
//                }
//                
//                
//                self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x,self.diskInfoLab1.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
//                
//                self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
//                
//                _cancelBtn.hidden = NO;
//                _deleteOKBtn.hidden = NO;
//                
//            } completion:^(BOOL finished){
//                self.downingSetEditModeFlag = @"0";
//            }];
            

        }
    }
//    else if(downloadingTable.tag == 0 &&downloadingTable.hidden == NO){
//        [UIView animateWithDuration:.1 animations:^{
//            
//            for (NSIndexPath* i in [downloadingTable indexPathsForVisibleRows])
//            {
//                DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:i];
//                
////                if ([self.downingSelectList containsObject:i]) {
////                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
////                }else{
////                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
////                }
//                
//                
////                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x + 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
////                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x + 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
////                cell.finishCountLabel.frame =CGRectMake(cell.finishCountLabel.frame.origin.x + 25, cell.finishCountLabel.frame.origin.y, cell.finishCountLabel.frame.size.width, cell.finishCountLabel.frame.size.height);
////                cell.fileSize.frame = CGRectMake(cell.fileSize.frame.origin.x + 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
////                cell.checkBtn.hidden = NO;
////                [cell bringSubviewToFront:cell.checkBtn];
//                
//                
//            }
//            
//            _cancelBtn.hidden = NO;
//            _deleteOKBtn.hidden = NO;
//            self.downloadingTable.tag = 99;
//            
//            
//            
//            self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x,self.diskInfoLab1.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
//            
//            self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y -_cancelBtn.frame.size.height, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
//            
//            
//            
//        } completion:^(BOOL finished){
//            
//        }];
//        
//    }
    
    
    
}


-(IBAction)cancelClick{
    if (self.navigationItem.rightBarButtonItem.tag == 99 &&finishedTable.hidden == NO) {//已经下载完成的表格

    
        self.navigationItem.rightBarButtonItem.tag = 0;
        
        [UIView animateWithDuration:.3 animations:^{
            
            for (NSIndexPath* i in [finishedTable indexPathsForVisibleRows])
            {
                FinishedCell *cell = [finishedTable cellForRowAtIndexPath:i];
                

                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x - 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x - 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
                cell.finishCountLabel.frame =CGRectMake(cell.finishCountLabel.frame.origin.x - 25, cell.finishCountLabel.frame.origin.y, cell.finishCountLabel.frame.size.width, cell.finishCountLabel.frame.size.height);
                cell.fileSize.frame = CGRectMake(cell.fileSize.frame.origin.x - 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
                cell.checkBtn.hidden = YES;

            }

            self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y + 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
            
            self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  + 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
            
            _cancelBtn.hidden = YES;
            _deleteOKBtn.hidden = YES;
            
        } completion:^(BOOL finished){
            
            
        }];

    }else if(finishedTable.hidden == YES &&[@"1" isEqualToString:self.downingSetEditModeFlag]){
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            for (NSIndexPath* i in [downloadingTable indexPathsForVisibleRows])
            {
                DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:i];
                
                
                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x - 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x - 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);

                cell.courseDesc.frame = CGRectMake(cell.courseDesc.frame.origin.x - 25, cell.courseDesc.frame.origin.y, cell.courseDesc.frame.size.width, cell.courseDesc.frame.size.height);
                cell.checkBtn.hidden = YES;
                
            }
            
            self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y + 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
            
            self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  + 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
            
            _cancelBtn.hidden = YES;
            _deleteOKBtn.hidden = YES;
            
        } completion:^(BOOL finished){
            self.downingSetEditModeFlag = @"0";
            
        }];
        
    }
    
}

-(IBAction)deleteOKClick{
    if (finishedTable.hidden == NO) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:finishedList];
        
        NSMutableArray *deleteCouresArray = [NSMutableArray array];
        for (int i = 0 ; i < [_downloadSelectList count]; i++) {
            NSIndexPath *indexPath = [_downloadSelectList objectAtIndex:i];
            [deleteCouresArray addObject:[tempArray objectAtIndex:indexPath.row]];
            [finishedList removeObject:[tempArray objectAtIndex:indexPath.row]];
        }
        [[FilesDownManage sharedFilesDownManage]  deleteFinishGroup:deleteCouresArray];
        
        
        [_downloadSelectList removeAllObjects];
        
        self.navigationItem.rightBarButtonItem.tag = 0;
        
        [UIView animateWithDuration:.3 animations:^{
            
            for (NSIndexPath* i in [finishedTable indexPathsForVisibleRows])
            {
                FinishedCell *cell = [finishedTable cellForRowAtIndexPath:i];
                
                
                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x - 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x - 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
                cell.finishCountLabel.frame =CGRectMake(cell.finishCountLabel.frame.origin.x - 25, cell.finishCountLabel.frame.origin.y, cell.finishCountLabel.frame.size.width, cell.finishCountLabel.frame.size.height);
                cell.fileSize.frame = CGRectMake(cell.fileSize.frame.origin.x - 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
                cell.checkBtn.hidden = YES;
                
            }
            self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y + 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
            
            self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  + 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
            
            _cancelBtn.hidden = YES;
            _deleteOKBtn.hidden = YES;
            
        } completion:^(BOOL finished){
            [self.finishedTable reloadData];
            self.diskInfoLab1.text = [CommonHelper getDiskSpaceInfo];
            long totalDownloadSize = 0;
            
            for (int i = 0 ; i < [self.finishedList count]; i ++) {
                NSDictionary *lineDict = [self.finishedList objectAtIndex:i];
                NSString *totalSize = [lineDict objectForKey:@"TOTAL_SIZE"];
                int size = totalSize.intValue;
                totalDownloadSize += size;
            }
            self.diskInfoLab.text = [NSString stringWithFormat:@"已下载%.2fG",totalDownloadSize/1024.0f/1024.0f/1024.0f];
            
        }];
    }else{
        
        NSMutableArray *deleteRequest = [NSMutableArray array];
        MidHttpRequest *executeingRequest = nil;
        for (int i = 0 ; i < [_downingSelectList count]; i++) {
            NSIndexPath *indexPath = [_downingSelectList objectAtIndex:i];
            MidHttpRequest *theRequest=[downingList objectAtIndex:indexPath.row];
            if ([theRequest isExecuting]) {
                executeingRequest = theRequest;
            }else{
                [deleteRequest addObject:theRequest];
            }
        }
        if(executeingRequest != nil){
            [deleteRequest addObject:executeingRequest];
        }
        
        while ([deleteRequest count] > 0) {
            [[FilesDownManage sharedFilesDownManage] deleteRequest:[deleteRequest objectAtIndex:0]];
            [deleteRequest removeObjectAtIndex:0];
        }
        
        
//        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:downingList];
//
//        for (int i = 0 ; i < [_downingSelectList count]; i++) {
//            NSIndexPath *indexPath = [_downingSelectList objectAtIndex:i];
//            MidHttpRequest *theRequest=[tempArray objectAtIndex:indexPath.row];
//            
//            [[FilesDownManage sharedFilesDownManage] deleteRequest:theRequest];
//            [downingList removeObject:[tempArray objectAtIndex:indexPath.row]];
//        }

        [_downingSelectList removeAllObjects];
        
        self.downingSetEditModeFlag = @"0";

        [UIView animateWithDuration:.3 animations:^{
            
            for (NSIndexPath* i in [downloadingTable indexPathsForVisibleRows])
            {
                DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:i];

                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x - 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x - 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);

                cell.courseDesc.frame = CGRectMake(cell.fileSize.frame.origin.x - 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
                cell.checkBtn.hidden = YES;
                
            }
            self.diskInfoLab1.frame = CGRectMake(self.diskInfoLab1.frame.origin.x, self.diskInfoLab1.frame.origin.y + 45, self.diskInfoLab1.frame.size.width, self.diskInfoLab1.frame.size.height);
            
            self.diskInfoLab.frame = CGRectMake(self.diskInfoLab.frame.origin.x, self.diskInfoLab.frame.origin.y  + 45, self.diskInfoLab.frame.size.width, self.diskInfoLab.frame.size.height);
            
            _cancelBtn.hidden = YES;
            _deleteOKBtn.hidden = YES;
            
        } completion:^(BOOL finished){
            [self.downloadingTable reloadData];
            self.diskInfoLab1.text = [CommonHelper getDiskSpaceInfo];
            long totalDownloadSize = 0;
            
            for (int i = 0 ; i < [self.finishedList count]; i ++) {
                NSDictionary *lineDict = [self.finishedList objectAtIndex:i];
                NSString *totalSize = [lineDict objectForKey:@"TOTAL_SIZE"];
                int size = totalSize.intValue;
                totalDownloadSize += size;
            }
            self.diskInfoLab.text = [NSString stringWithFormat:@"已下载%.2fG",totalDownloadSize/1024.0f/1024.0f/1024.0f];
            
        }];
        
    }
    

    
    
}

-(void)setEditMode{
    if (editBtn.tag == 999) {
//        [self.downloadingTable setEditing:YES animated:YES];
//        [self.finishedTable setEditing:YES animated:YES];

        editBtn.tag = 0;
        editBtn.title = @"完成";
        

        
        [UIView animateWithDuration:.3 animations:^{
            
            for (NSIndexPath* i in [finishedTable indexPathsForVisibleRows])
            {
                FinishedCell *cell = [finishedTable cellForRowAtIndexPath:i];
                
                if ([self.downloadSelectList containsObject:i]) {
                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                }else{
                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
                }
                
                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x + 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x + 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
                cell.finishCountLabel.frame =CGRectMake(cell.finishCountLabel.frame.origin.x + 25, cell.finishCountLabel.frame.origin.y, cell.finishCountLabel.frame.size.width, cell.finishCountLabel.frame.size.height);
                cell.fileSize.frame = CGRectMake(cell.fileSize.frame.origin.x + 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
                cell.checkBtn.hidden = NO;
                [cell bringSubviewToFront:cell.checkBtn];
                
            }
            
        } completion:^(BOOL finished){
        }];

    }else{
//        [self.downloadingTable setEditing:NO animated:YES];
//        [self.finishedTable setEditing:NO animated:YES];
        editBtn.tag = 999;
        editBtn.title = @"编辑";
        
        
        
        NSMutableArray *deleteCouresArray = [NSMutableArray array];
        for (int i = 0 ; i < [_downloadSelectList count]; i++) {
            NSIndexPath *indexPath = [_downloadSelectList objectAtIndex:i];
            [deleteCouresArray addObject:[finishedList objectAtIndex:indexPath.row]];
            [finishedList removeObjectAtIndex:indexPath.row];
        }
        [[FilesDownManage sharedFilesDownManage]  deleteFinishGroup:deleteCouresArray];
        
        
        [_downloadSelectList removeAllObjects];
        
        //        FileModel *selectFile=[self.finishedList objectAtIndex:indexPath.row];
        //        [[FilesDownManage sharedFilesDownManage]  deleteFinishFile:selectFile];
        [self.finishedTable reloadData];
        
        
        //[finishedTable reloadData];
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            for (NSIndexPath* i in [finishedTable indexPathsForVisibleRows])
            {
                FinishedCell *cell = [finishedTable cellForRowAtIndexPath:i];
                
//                if ([self.downloadSelectList containsObject:i]) {
//                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
//                }else{
//                    [cell.checkBtn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
//                }
                
                
                cell.fileImage.frame = CGRectMake(cell.fileImage.frame.origin.x - 25, cell.fileImage.frame.origin.y, cell.fileImage.frame.size.width, cell.fileImage.frame.size.height);
                cell.fileName.frame  = CGRectMake(cell.fileName.frame.origin.x - 25, cell.fileName.frame.origin.y, cell.fileName.frame.size.width, cell.fileName.frame.size.height);
                cell.finishCountLabel.frame =CGRectMake(cell.finishCountLabel.frame.origin.x - 25, cell.finishCountLabel.frame.origin.y, cell.finishCountLabel.frame.size.width, cell.finishCountLabel.frame.size.height);
                cell.fileSize.frame = CGRectMake(cell.fileSize.frame.origin.x - 25, cell.fileSize.frame.origin.y, cell.fileSize.frame.size.width, cell.fileSize.frame.size.height);
                cell.checkBtn.hidden = YES;
//                [cell bringSubviewToFront:cell.checkBtn];
                
            }
            
        } completion:^(BOOL finished){
            
            
        }];
    }
    
    
    
}
-(void)goback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidUnload
{

    [self setDownloadingViewBtn:nil];
    [self setFinieshedViewBtn:nil];
    
    [self setEditbtn:nil];
    clearallbtn = nil;
    backbtn = nil;
    [self setDiskInfoLab:nil];
    [self setBandwithLab:nil];
    [self setNoLoadsInfo:nil];
   
    self.downloadingTable=nil;
    self.finishedTable=nil;
     [super viewDidUnload];
}
-(void)checked:(id)sender{
    
    UIButton *btn = (UIButton *) sender;
 
    int index = btn.tag - 10 ;
    if(finishedTable.hidden == NO){
        
        NSIndexPath *indexPath = [[finishedTable indexPathsForVisibleRows]  objectAtIndex:index];
        FinishedCell *cell = [finishedTable cellForRowAtIndexPath:indexPath];
        
        if ([self.downloadSelectList containsObject:indexPath]) {
            
            [self.downloadSelectList  removeObject:indexPath];
            [btn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            cell.tag = 0;
            
            
            
        }else{
            [self.downloadSelectList addObject:indexPath];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            cell.tag = 999;


        }
        [_deleteOKBtn setTitle:[NSString stringWithFormat:@"删除(%d)",[self.downloadSelectList count]] forState:UIControlStateNormal];
    }else{
        NSIndexPath *indexPath = [[downloadingTable indexPathsForVisibleRows]  objectAtIndex:index];
        DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:indexPath];
        if ([self.downingSelectList containsObject:indexPath]) {
            
            [self.downingSelectList  removeObject:indexPath];
            [btn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            cell.tag = 0;
            
        }else{
            [self.downingSelectList addObject:indexPath];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            cell.tag = 999;

        }
        [_deleteOKBtn setTitle:[NSString stringWithFormat:@"删除(%d)",[self.downingSelectList count]] forState:UIControlStateNormal];
    }


}

-(UIBarButtonItem*)makeCustomRightBarButItem:(NSString *)titlestr action:(SEL)action{
    CGRect frame_1= CGRectMake(0, 0, 45, 27);
    UIImage* image= [UIImage imageNamed:@"顶部按钮背景.png"];
    UIButton* showfinishbtn= [[UIButton alloc] initWithFrame:frame_1];
    [showfinishbtn setBackgroundImage:image forState:UIControlStateNormal];
    [showfinishbtn setTitle:titlestr forState:UIControlStateNormal];
    [showfinishbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    showfinishbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [showfinishbtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* showFinishedBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:showfinishbtn];
    return showFinishedBarButtonItem;
}

- (void)updateImageForCellAtIndexPath:(NSMutableDictionary *)dict
{
    
    NSIndexPath *index = [dict objectForKey:@"indexPath"];
    NSString *imagePath = [dict objectForKey:@"imagePath"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
    
    if (imageData != nil) {
        NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
        [parmDict setObject:imageData forKey:@"imageData"];
        [parmDict setObject:index forKey:@"indexPath"];
        
        [self performSelectorOnMainThread:@selector(setImage:) withObject:parmDict waitUntilDone:NO];
    }
}


- (void)updateImageForFinishCellAtIndexPath:(NSMutableDictionary *)dict
{
    
    NSIndexPath *index = [dict objectForKey:@"indexPath"];
    NSString *imagePath = [dict objectForKey:@"imagePath"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
    
    if (imageData != nil) {
        NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
        [parmDict setObject:imageData forKey:@"imageData"];
        [parmDict setObject:index forKey:@"indexPath"];
        
        [self performSelectorOnMainThread:@selector(setFinishImage:) withObject:parmDict waitUntilDone:NO];
    }
}


-(void)setImage:(NSMutableDictionary *)dict{
    NSIndexPath *index = [dict objectForKey:@"indexPath"];
    NSData *imageData = [dict objectForKey:@"imageData"];
    DownloadCell *cell = [self.downloadingTable cellForRowAtIndexPath:index];
    cell.fileImage.image = [UIImage imageWithData:imageData];
}
-(void)setFinishImage:(NSMutableDictionary *)dict{
    NSIndexPath *index = [dict objectForKey:@"indexPath"];
    NSData *imageData = [dict objectForKey:@"imageData"];
    FinishedCell *cell = [self.finishedTable cellForRowAtIndexPath:index];
    cell.fileImage.image = [UIImage imageWithData:imageData];
}

#pragma mark ---UITableView Delegate---

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.downloadingTable)
    {
        if (self.downingList.count==0) {
            if (self.downloadingTable.hidden) {
                self.noLoadsInfo.hidden = YES;
            }else
            self.noLoadsInfo.hidden = NO;
        }else
            self.noLoadsInfo.hidden = YES;
        return [self.downingList count];
    }
    else
    {
        return [self.finishedList count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.downloadingTable)//正在下载的文件列表
    {
        static NSString *downCellIdentifier=@"DownloadCell";
        DownloadCell *cell=(DownloadCell *)[tableView dequeueReusableCellWithIdentifier:downCellIdentifier];
        cell.delegate = self;
        [cell.progress1 setTrackImage:[UIImage imageNamed:@"下载管理进度条背景.png"]];
        [cell.progress1 setProgressImage:[UIImage imageNamed:@"下载管理进度背景点九.png"]];


        MidHttpRequest *theRequest=[self.downingList objectAtIndex:indexPath.row];
        if (theRequest==nil) {
            return cell=Nil;
        }
        FileModel *fileInfo=[theRequest.userInfo objectForKey:@"File"];
        NSString *currentsize =fileInfo.fileReceivedSize;
        NSString *totalsize = [CommonHelper getFileSizeString:fileInfo.fileSize];
        cell.fileName.text=fileInfo.chapterName;

        
        
        if ([@"0" isEqualToString:currentsize]) {
            cell.fileCurrentSize.text =@"等待中";
        }else{
            cell.fileCurrentSize.text= [NSString stringWithFormat:@"%.2f/%@",[currentsize intValue]/1024.00/1024.00,[NSString stringWithFormat:@"%@",[CommonHelper getFileSizeString:fileInfo.fileSize]]];;
        }
        cell.fileSize.text=[NSString stringWithFormat:@"大小:%@",totalsize];
       // cell.sizeinfoLab.text = [NSString stringWithFormat:@"%@/%@",currentsize,totalsize];
        cell.fileInfo=fileInfo;
        cell.request=theRequest;
        cell.fileTypeLab.text  =[NSString stringWithFormat:@"格式:%@",fileInfo.fileType] ;
        cell.timelable.text =[NSString stringWithFormat:@"%@",fileInfo.time] ;
        cell.timelable.hidden = YES;

        cell.courseDesc.text = fileInfo.courseDesc;
        cell.courseName.text = fileInfo.courseName;
        
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        cell.progress1.transform = transform;
        
        
        NSString *imagePath = fileInfo.imgPath;
        NSMutableDictionary *lineDictTemp = [NSMutableDictionary dictionary];
        [lineDictTemp setObject:imagePath forKey:@"imagePath" ];
        [lineDictTemp setObject:indexPath forKey:@"indexPath" ];
        
        [NSThread detachNewThreadSelector:@selector(updateImageForCellAtIndexPath:) toTarget:self withObject:lineDictTemp];
        
        
        if ([currentsize longLongValue]==0) {
            [cell.progress1 setProgress:0.0f];
        }else
        [cell.progress1 setProgress:[CommonHelper getProgress:[fileInfo.fileSize longLongValue] currentSize:[fileInfo.fileReceivedSize longLongValue]]];
        cell.sizeinfoLab.text =[NSString stringWithFormat:@"%0.0f%@",100*(cell.progress1.progress),@"%"];
        
       [cell.checkBtn addTarget:self action:@selector(checked:) forControlEvents:UIControlEventTouchUpInside];
       cell.checkBtn.tag = 10 + indexPath.row;
       // NSLog(@"process:%@",cell.sizeinfoLab.text);
        if(fileInfo.downloadState==Downloading)//文件正在下载
        {
            [cell.operateButton setBackgroundImage:[UIImage imageNamed:@"downloadstart.png"] forState:UIControlStateNormal];
        }
        else if(fileInfo.downloadState==StopDownload&&!fileInfo.error)
        {
            [cell.operateButton setBackgroundImage:[UIImage imageNamed:@"download_pausing_icon.png"] forState:UIControlStateNormal];
            cell.sizeinfoLab.text = @"暂停";
        }else if(fileInfo.downloadState==WillDownload&&!fileInfo.error)
        {
            [cell.operateButton setBackgroundImage:[UIImage imageNamed:@"download_pausing_icon.png"] forState:UIControlStateNormal];
            cell.sizeinfoLab.text = @"等待";
        }else if (fileInfo.error)
        {
            [cell.operateButton setBackgroundImage:[UIImage imageNamed:@"download_pausing_icon.png"] forState:UIControlStateNormal];
            cell.sizeinfoLab.text = @"错误";
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }

    else if(tableView==self.finishedTable)//已完成下载的列表
    {
      
        static NSString *finishedCellIdentifier=@"FinishedCell";
        FinishedCell *cell=(FinishedCell *)[self.finishedTable dequeueReusableCellWithIdentifier:finishedCellIdentifier];
          cell.delegate = self;

        NSDictionary  *finishDict=[self.finishedList objectAtIndex:indexPath.row];
        cell.fileName.text=[NSString stringWithFormat:@"%@",[finishDict objectForKey:@"NAME"]];
        
        
        cell.fileSize.text=[NSString stringWithFormat:@"大小 %@",[CommonHelper getFileSizeString:[finishDict objectForKey:@"TOTAL_SIZE"]]];
        
        //cell.finishCountLabel.text=[NSString stringWithFormat:@"下载 %@/%@",[finishDict objectForKey:@"FINISH_COUNT"],[finishDict objectForKey:@"TOTAL"]];
        
        cell.finishCountLabel.text=[NSString stringWithFormat:@"下载 %@",[finishDict objectForKey:@"FINISH_COUNT"]];
        
        [cell.checkBtn addTarget:self action:@selector(checked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.checkBtn.tag = 10 + indexPath.row;
        
        NSString *imagePath = [finishDict objectForKey:@"IMG_PATH"];
        NSMutableDictionary *lineDictTemp = [NSMutableDictionary dictionary];
        [lineDictTemp setObject:imagePath forKey:@"imagePath" ];
        [lineDictTemp setObject:indexPath forKey:@"indexPath" ];
        
        [NSThread detachNewThreadSelector:@selector(updateImageForFinishCellAtIndexPath:) toTarget:self withObject:lineDictTemp];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        return cell;
    }

    return nil;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView.tag == 101) {
//        return YES;
//
//    }
    return  NO;
    //return YES;
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除任务";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)//点击了删除按钮,注意删除了该视图列表的信息后，还要更新UI和APPDelegate里的列表
    {
//        if(tableView.tag==101)//已经完成下载的表格
//        {
//            FileModel *selectFile=[self.finishedList objectAtIndex:indexPath.row];
//            [[FilesDownManage sharedFilesDownManage]  deleteFinishFile:selectFile];
//            [self.finishedTable reloadData];
//        }
//#ifdef OPENFINISHLISTVIEW
//        else//正在下载列表的表格
//        {
//            
//            MidHttpRequest *theRequest=[self.downingList objectAtIndex:indexPath.row];
//            [[FilesDownManage sharedFilesDownManage] deleteRequest:theRequest];
//            [self.downloadingTable reloadData];
//
//        }
//#endif
        
        
//        if(tableView.tag!=101)//已经完成下载的表格
//        {
//            MidHttpRequest *theRequest=[self.downingList objectAtIndex:indexPath.row];
//            [[FilesDownManage sharedFilesDownManage] deleteRequest:theRequest];
//            [self.downloadingTable reloadData];
//        }
    }
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    //跳转到下一个页面
    if (self.finishedTable.hidden == NO &&self.navigationItem.rightBarButtonItem.tag != 99) {
        //1.storyboard中定义某个独立newViewController（无segue跳转关系）的 identifier
        static  NSString *controllerId =@"hdvc";
        
        //2.获取UIStoryboard对象
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        
        //3.从storyboard取得newViewCtroller对象，通过Identifier区分
        HaveDownloadViewController *vdvc = [story instantiateViewControllerWithIdentifier:controllerId];
        
        NSDictionary *lineDict = [finishedList objectAtIndex:indexPath.row];
        
        vdvc.courseId =  [lineDict objectForKey:@"ID"];
        vdvc.title = [lineDict objectForKey:@"NAME"];

        
        [self.navigationController pushViewController:vdvc animated:YES];

    //完成界面点击事件变成可勾选
    }else if (self.finishedTable.hidden == NO &&self.navigationItem.rightBarButtonItem.tag == 99){
        FinishedCell *cell = [self.finishedTable cellForRowAtIndexPath:indexPath];
        [self checked:cell.checkBtn];
    //正下载界面点击事件变成可勾选
    }else if (self.downloadingTable.hidden == NO && [self.downingSetEditModeFlag isEqualToString:@"1"]){
        DownloadCell *cell = [self.downloadingTable cellForRowAtIndexPath:indexPath];
        [self checked:cell.checkBtn];
    }

}

//点击效果
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    if(tableView.tag==101)//已经完成下载的表格
////    {
////        FileModel *fileInfo=[self.finishedList objectAtIndex:indexPath.row];
////
////
////        NSMutableArray *array = [NSMutableArray array];
////        
////        NSMutableDictionary *dict  = [NSMutableDictionary dictionary];
////        
////        [dict setObject:fileInfo.fileURL forKey:@"path"];
////        
////        [dict setObject:fileInfo.chapterName forKey:@"name"];
////        
////        [array addObject:dict];
////        
////        
////        MoviePlayerViewController *movieVC = [[MoviePlayerViewController alloc]initNetworkMoviePlayerViewControllerWithChapterList:array playIndex:0 courseName:@""];
////        [self presentViewController:movieVC animated:YES completion:nil];
////
////    }
//    
//    if(tableView.tag==101){
//        NSDictionary *lineDict = [finishedList objectAtIndex:indexPath.row];
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
//        
//        HaveDownloadViewController *hdvc = [story instantiateViewControllerWithIdentifier:@"hdvc"];
//        
//        
//        hdvc.courseId =  [lineDict objectForKey:@"ID"];
//        [self presentViewController:hdvc animated:YES completion:nil];
//
//    
//        
//    }
//}
-(void)viewDidLayoutSubviews
{
    if ([finishedTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [finishedTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([finishedTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [finishedTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)updateCellOnMainThread:(FileModel *)fileInfo
{
//    self.bandwithLab.text = [NSString stringWithFormat:@"%@/S",[CommonHelper getFileSizeString:[NSString stringWithFormat:@"%lu",[ASIHTTPRequest averageBandwidthUsedPerSecond]]]] ;
    NSArray* cellArr = [self.downloadingTable visibleCells];
    for(id obj in cellArr)
    {
        if([obj isKindOfClass:[DownloadCell class]])
        {
            DownloadCell *cell=(DownloadCell *)obj;
            if([cell.fileInfo.fileURL isEqualToString: fileInfo.fileURL])
            {
                NSString *currentsize;
           
                   currentsize = fileInfo.fileReceivedSize;
                NSString *totalsize = [CommonHelper getFileSizeString:fileInfo.fileSize];

               cell.fileCurrentSize.text= [NSString stringWithFormat:@"%.2f/%@",[currentsize intValue]/1024.00/1024.00,[NSString stringWithFormat:@"%@",[CommonHelper getFileSizeString:fileInfo.fileSize]]];
                

                

                cell.fileSize.text = [NSString stringWithFormat:@"大小:%@",totalsize];
//                cell.sizeinfoLab.text = [NSString stringWithFormat:@"%@/%@",currentsize,totalsize];
//                NSLog(@"%@",cell.sizeinfoLab.text);
                
                [cell.progress1 setProgress:[CommonHelper getProgress:[fileInfo.fileSize longLongValue] currentSize:[currentsize longLongValue]]];
                NSLog(@"进度%f",cell.progress1 .progress);

                 cell.sizeinfoLab.text =[NSString stringWithFormat:@"%.0f%@",100*(cell.progress1.progress),@"%"];
//                cell.averagebandLab.text =[NSString stringWithFormat:@"%@/s",[CommonHelper getFileSizeString:[NSString stringWithFormat:@"%lu",[ASIHTTPRequest averageBandwidthUsedPerSecond]]]] ;
				if(fileInfo.downloadState==Downloading)//文件正在下载
				{
					[cell.operateButton setBackgroundImage:[UIImage imageNamed:@"downloadstart.png"] forState:UIControlStateNormal];
				}
				else if(fileInfo.downloadState==StopDownload&&!fileInfo.error)
				{
					[cell.operateButton setBackgroundImage:[UIImage imageNamed:@"download_pausing_icon.png"] forState:UIControlStateNormal];
					cell.sizeinfoLab.text = @"暂停";
				}else if(fileInfo.downloadState==WillDownload&&!fileInfo.error)
				{
					[cell.operateButton setBackgroundImage:[UIImage imageNamed:@"download_pausing_icon.png"] forState:UIControlStateNormal];
					cell.sizeinfoLab.text = @"等待";
				}else if (fileInfo.error)
				{
					[cell.operateButton setBackgroundImage:[UIImage imageNamed:@"download_pausing_icon.png"] forState:UIControlStateNormal];
					cell.sizeinfoLab.text = @"错误";
				}
            }
        }
    }
}

#pragma mark --- updateUI delegate ---
-(void)startDownload:(MidHttpRequest *)request;
{
    NSLog(@"-------开始下载!");
}

-(void)updateCellProgress:(MidHttpRequest *)request;
{
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    [self performSelectorOnMainThread:@selector(updateCellOnMainThread:) withObject:fileInfo waitUntilDone:YES];
}

-(void)finishedDownload:(MidHttpRequest *)request;
{
    
    
    
   // [self.downingList removeObject:request];
    [self.downloadingTable reloadData];
     self.bandwithLab.text = @"0.00K/S";
    [[FilesDownManage sharedFilesDownManage] loadFinishedfiles];
    
    self.finishedList=[FilesDownManage sharedFilesDownManage].finishedlist;

    [self.finishedTable reloadData];
    
    
    long totalDownloadSize = 0;
    
    for (int i = 0 ; i < [self.finishedList count]; i ++) {
        NSDictionary *lineDict = [self.finishedList objectAtIndex:i];
        NSString *totalSize = [lineDict objectForKey:@"TOTAL_SIZE"];
        int size = totalSize.intValue;
        totalDownloadSize += size;
    }
    self.diskInfoLab.text = [NSString stringWithFormat:@"已下载%.2fG",totalDownloadSize/1024.0f/1024.0f/1024.0f];
    
    
    [self.downingSelectList removeAllObjects];
    //遍历重新获取选中的cell
    for (NSIndexPath* i in [downloadingTable indexPathsForVisibleRows])
    {
        DownloadCell *cell = [downloadingTable cellForRowAtIndexPath:i];
        if (cell.tag == 999) {
            [self.downingSelectList addObject:i];
        }
    }
    
    [self.downloadSelectList removeAllObjects];
    //遍历重新获取选中的cell
    for (NSIndexPath* i in [finishedTable indexPathsForVisibleRows])
    {
        FinishedCell *cell = [finishedTable cellForRowAtIndexPath:i];
        if (cell.tag == 999) {
            [self.downloadSelectList addObject:i];
        }
    }



}
- (void)deleteFinishedFile:(FileModel *)selectFile
{
    self.finishedList = [self getFinished ];
    [self.finishedTable reloadData];
}
-(void)ReloadDownLoadingTable
{
    self.downingList =[FilesDownManage sharedFilesDownManage].downinglist;
    
//    if (self.downingList == nil ||[self.downingList count] == 0) {
//        self.downingList  = [self getDownloading];
//        [FilesDownManage sharedFilesDownManage].downinglist = self.downingList;
//    }
    
//self.downingList  = [self getDownloading];
    
    [self.downloadingTable reloadData];
}
-(NSMutableArray *)getDownloading{
    
    
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM CHAPTER_LIST WHERE DOWNLOAD_FINISH !='2'"];
    
    FMResultSet *rs = [appDelegate.db executeQuery:querySql];
    
    while (rs.next) {
        FileModel *fileinfo = [[FileModel alloc] init];
        fileinfo.chapterId = [rs stringForColumn:@"ID"];
        fileinfo.fileName = [rs stringForColumn:@"FILE_NAME"];
        fileinfo.fileURL = [rs stringForColumn:@"DOWNLOAD_PATH"];
        fileinfo.fileType = [[rs stringForColumn:@"FILE_NAME"] pathExtension];
        fileinfo.courseId = [rs stringForColumn:@"COURSE_ID"];
        fileinfo.courseName = [rs stringForColumn:@"FILE_NAME"];
        fileinfo.targetPath = @"dest";
        fileinfo.downloadState = StopDownload;
        
        NSString *tempfilePath= [TEMPPATH stringByAppendingPathComponent: fileinfo.fileName];
        fileinfo.tempPath = tempfilePath;
        MidHttpRequest* midRequest = [[MidHttpRequest alloc]initWithURL: [NSURL URLWithString:fileinfo.fileURL]];
        midRequest.downloadDestinationPath = fileinfo.targetPath;
        midRequest.temporaryFileDownloadPath = fileinfo.tempPath;
        [midRequest setUserInfo:[NSDictionary dictionaryWithObject:fileinfo forKey:@"File"]];

        [retArray addObject:midRequest];

    }
    return retArray;
    
}


-(NSMutableArray *)getFinished{
    
    
    
    NSMutableArray *tvArray = [NSMutableArray array];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT COL.ID,COL.NAME,COL.TEACHER,COL.IMG_PATH,COUNT(1) TOTAL,SUM(CASE WHEN DOWNLOAD_FINISH = '2' THEN 1 ELSE 0 END ) FINISH_COUNT,SUM(CASE WHEN DOWNLOAD_FINISH = '2' THEN SIZE/1024/1024 ELSE 0 END) TOTAL_SIZE FROM COURSE_LIST COL,CHAPTER_LIST  CHL WHERE COL.ID = CHL.COURSE_ID GROUP BY COL.ID,COL.NAME,COL.TEACHER,COL.IMG_PATH"];
    
    NSLog(@"下载管理课程列表下载 sql = %@",querySql);
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    FMResultSet *rs = [appDelegate.db executeQuery:querySql];
    
    while (rs.next) {
        NSMutableDictionary *lineDict = [NSMutableDictionary dictionary];
        [lineDict setObject:[rs stringForColumn:@"ID"] forKey:@"ID"];
        [lineDict setObject:[rs stringForColumn:@"NAME"] forKey:@"NAME"];
        [lineDict setObject:[rs stringForColumn:@"IMG_PATH"] forKey:@"IMG_PATH"];
        [lineDict setObject:[rs stringForColumn:@"TOTAL"] forKey:@"TOTAL"];
        [lineDict setObject:[rs stringForColumn:@"FINISH_COUNT"] forKey:@"FINISH_COUNT"];
        [lineDict setObject:[rs stringForColumn:@"TOTAL_SIZE"] forKey:@"TOTAL_SIZE"];
        
        [tvArray addObject:lineDict];
    }
    
    return tvArray;

    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toDetail"])
    {
        FinishedCell *cell = (FinishedCell *)sender;
        
        NSDictionary *lineDict = [finishedList objectAtIndex:cell.checkBtn.tag - 10 ];
        
        HaveDownloadViewController *vdvc = segue.destinationViewController;
        
        
        vdvc.courseId =  [lineDict objectForKey:@"ID"];
        
        

               //可以通过 segue.destinationviewcontroller获得跳转的下一个controller  可以直接调用其方法
        //记得 加上头文件      #import "otherController.h"
//        [segue.destinationViewController showTitle:title];
    }
}
//-(BOOL) respondsToSelector:(SEL)aSelector {
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
//    return [super respondsToSelector:aSelector];
//}

-(void)showAllTextDialog:(NSString *)str
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = str;
    HUD.mode = MBProgressHUDModeText;
    HUD.labelFont = [UIFont systemFontOfSize:13.0f];
    
    //指定距离中心点的X轴和Y轴的位置，不指定则在屏幕中间显示
    HUD.yOffset = 200.0f;
    //HUD.xOffset = 100.0f;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
        //        [HUD release];
    }];
    
}




@end
