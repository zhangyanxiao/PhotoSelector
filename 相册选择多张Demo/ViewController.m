//
//  ViewController.m
//  相册选择多张Demo
//
//  Created by 张艳晓 on 15/12/22.
//  Copyright © 2015年 zyx. All rights reserved.
//

#import "ViewController.h"
#import "CTAssetsPickerController.h"
#import "NSDate+TimeInterval.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UIButton * button;
@property (nonatomic, strong)UIButton * videoButton;
@property (nonatomic, strong)UIImageView * imv;
@property (nonatomic, strong)UIImagePickerController * picker;
@property (nonatomic, strong)UILabel * timeLabel;
//视频文件地址
@property(nonatomic,strong)NSURL * videoUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.button.frame = CGRectMake(0, 0, 200, 50);
    self.button.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/3.0);
    self.button.backgroundColor = [UIColor redColor];
    [self.button addTarget:self action:@selector(buttonAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];

    self.imv = [[UIImageView alloc] init];
    self.imv.frame = CGRectMake(0, 0, 100, 100);
    self.imv.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.imv];

    self.videoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.videoButton.frame = CGRectMake(0, 0, 200, 50);
    self.videoButton.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.videoButton.backgroundColor = [UIColor redColor];
    [self.videoButton setTitle:@"视频" forState:(UIControlStateNormal)];
    [self.videoButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview: self.videoButton];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.frame = CGRectMake(10, 400, 300, 50);
    self.timeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.timeLabel];
    self.timeLabel.text = [NSDate timeDescriptionOfTimeInterval:137894567];
//    []
}

- (void)buttonAction1:(UIButton *)sender
{
    CTAssetsPickerController * picker = [[CTAssetsPickerController alloc] init];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)buttonAction:(UIButton *)sender
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"照片" message:@"选择照片" preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction * action = [UIAlertAction actionWithTitle:@"打开相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;

        self.picker =picker;
        // 打开相册
        [self presentViewController:self.picker animated:YES completion:nil];
    }];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"打开相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        self.picker =picker;
        // 打开相册
        [self presentViewController:self.picker animated:YES completion:nil];

    }];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    NSLog(@"%@",info);
    // 获取相机的medieType
    NSString * mediaType = info[UIImagePickerControllerMediaType];
    // 如果照相机选得图片
    if ([mediaType isEqualToString:@"public.image"]) {
        // 把照片放入数组
        [self.imvDataArray addObject:info[UIImagePickerControllerEditedImage]];
    } else if([mediaType isEqualToString:@"public.movie"]){
        // 获取视频的url
        NSURL * url = info[UIImagePickerControllerMediaURL];
        self.videoUrl = url;
        // 是一个特定的视频有资格被保存到保存的照片专辑？
        BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([url path]);
        if (compatible) {
            // 为保存的相册添加一个视频
            UISaveVideoAtPathToSavedPhotosAlbum([url path], self, nil, nil);
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self saveVideo];
        });


    }else {

    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)saveVideo{

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

// 视频***********************
-(void)videoButtonAction:(UIButton *)sender
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
// 录制视频*************
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"录制视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"相机不可用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alter show];

        } else {

            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.allowsEditing = YES;
            self.picker.videoMaximumDuration = 20;
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.mediaTypes = [[NSArray alloc] initWithObjects:@"public.movie", nil];
            [self presentViewController:self.picker animated:YES completion:nil];


        }

    }];
    [alert addAction:action];
//  从已有视频中选取**************
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        self.picker = [[UIImagePickerController alloc] init];
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        self.picker.mediaTypes = [[NSArray alloc] initWithObjects:@"public.movie", nil];
        self.picker.delegate = self;
        [self presentViewController:self.picker animated:YES completion:nil];

    }];
    [alert addAction:action1];



    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
