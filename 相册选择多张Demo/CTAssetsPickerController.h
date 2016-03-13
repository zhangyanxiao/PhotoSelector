
/*
 CTAssetsPickerController.h
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */


#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@class CTAssetsPickerController;
/**------------这个协议的方法通知你的代表，当用户完成采摘的照片或视频，或取消选择操作。
 The CTAssetsPickerControllerDelegate protocol defines methods that your delegate object must implement to interact with the assets picker interface. The methods of this protocol notify your delegate when the user finish picking photos or videos, or cancels the picker operation.这个协议的方法通知你的代表，当用户完成采摘的照片或视频，或取消选择操作。
 */
@protocol CTAssetsPickerControllerDelegate <NSObject>

/**
 Tells the delegate that the user finish picking photos or videos.告诉委托用户完成采摘照片或视频。
 @param picker The controller object managing the assets picker interface.
 @param assets An array containing picked ALAsset objects
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;

@optional

/**-------------告诉委托用户完成采摘照片或视频

 Tells the delegate that the user cancelled the pick operation.告诉委托用户完成采摘照片或视频
 @param picker The controller object managing the assets picker interface.
 */
- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker;

@end

//一个控制器，允许从用户的照片库中提取多个照片和视频。
@interface CTAssetsPickerController : UINavigationController

/// The assets picker’s delegate object.
@property (nonatomic, assign) id <UINavigationControllerDelegate, CTAssetsPickerControllerDelegate> delegate;

/// Set the ALAssetsFilter to filter the picker contents. 设置alassetsfilter过滤选择器的内容。
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

/// The maximum number of assets to be picked.被选的资产的最大数量。
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;

/**
 Determines whether or not the cancel button is visible in the picker默认情况下，可以看到“取消”按钮
 @discussion The cancel button is visible by default. To hide the cancel button, (e.g. presenting the picker in UIPopoverController)
 set this property’s value to NO.
 */
@property (nonatomic, assign) BOOL showsCancelButton;

@end



