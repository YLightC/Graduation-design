//
//  AddDelActivityViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/4/18.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Alamofire

class AddDelActivityViewController: UIViewController {
    
    //时间选择器
    let datePicker = UIDatePicker()
    // 海报
    let Image = UIImageView()
    //确认添加活动
    let applyButton = UIButton()
    //添加活动海报
    let addCoverButton = UIButton()
    //活动名称
    let activityNameLabel = UILabel()
    let activityNameText = UITextField()
    //活动其实时间
    let activityStarttimeLabel = UILabel()
    let activityStarttimeText = UITextField()
    //活动地址
    let activityAddressLabel = UILabel()
    let activityAddressText = UITextField()
    
    let addAc = AddActivityM()
    var string = ""
    var starttime = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAc.delegate = self
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "管理"
        self.automaticallyAdjustsScrollViewInsets = false
        addDatePicker()
        addCovers()
        addCoversButton()
        addActivityName()
        activityTime()
        addAddress()
        initApplyButton() //确定按钮
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //时间选择器布局
    func addDatePicker() {
        self.view.addSubview(datePicker)
        datePicker.datePickerMode = .Date
        datePicker.snp_makeConstraints(closure: { make  in
            make.top.equalTo(70)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(70)
        })
    }
    
    //活动海报布局
    func addCovers() {
        self.view.addSubview(Image)
        Image.snp_makeConstraints(closure: { make in
            make.top.equalTo(datePicker.snp_bottom).offset(5)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(200)
        })
        Image.clipsToBounds = true
        Image.contentMode = .ScaleAspectFill
        Image.layer.borderWidth = 0.5
        Image.layer.borderColor = UIColor ( red: 0.5216, green: 0.8314, blue: 1.0, alpha: 1.0 ).CGColor
    }
    
    func addCoversButton() {
       self.view.addSubview(addCoverButton)
        addCoverButton.snp_makeConstraints(closure:{ make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(Image.snp_bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        addCoverButton.backgroundColor = UIColor.blackColor()
        addCoverButton.setTitle("添加图片", forState: .Normal)
        addCoverButton.setTitleColor(UIColor.whiteColor(), forState:.Normal)
        addCoverButton.addTarget(self, action: #selector(AddDelActivityViewController.tapAddButton), forControlEvents: .TouchUpInside)
    }
    
    //活动名称
    func addActivityName() {
        self.view.addSubview(activityNameLabel)
        self.view.addSubview(activityNameText)
        
        activityNameLabel.sizeToFit()
        activityNameLabel.text = "活动名称:"
        activityNameLabel.textAlignment = NSTextAlignment.Left
        activityNameLabel.snp_makeConstraints(closure: { make in
            make.top.equalTo(addCoverButton.snp_bottom).offset(10)
            make.width.equalTo(73)
            make.left.equalTo(20)
        })
        
        activityNameText.placeholder = "请输入活动名称"
        activityNameText.snp_makeConstraints(closure: { make in
            make.top.equalTo(addCoverButton.snp_bottom).offset(10)
            make.left.equalTo(activityNameLabel.snp_right).offset(5)
            make.right.equalTo(-20)
        })
        activityNameText.backgroundColor = UIColor ( red: 0.5216, green: 0.8314, blue: 1.0, alpha: 1.0 )
    }
    
    //活动时间
    func activityTime() {
        self.view.addSubview(activityStarttimeLabel)
        self.view.addSubview(activityStarttimeText)
        
        activityStarttimeLabel.sizeToFit()
        activityStarttimeLabel.text = "活动时间:"
        activityStarttimeLabel.textAlignment = NSTextAlignment.Right
        activityStarttimeLabel.snp_makeConstraints(closure: { make in
            make.top.equalTo(activityNameLabel.snp_bottom).offset(10)
            make.width.equalTo(73)
            make.left.equalTo(20)
        })
        
        activityStarttimeText.placeholder = "开始时间,请用时间选择器选择"
        activityStarttimeText.userInteractionEnabled = false
        
        activityStarttimeText.snp_makeConstraints(closure: { make in
            make.top.equalTo(activityNameLabel.snp_bottom).offset(10)
            make.left.equalTo(activityStarttimeLabel.snp_right).offset(5)
            make.right.equalTo(-20)
        })
        activityStarttimeText.backgroundColor = UIColor ( red: 0.5216, green: 0.8314, blue: 1.0, alpha: 1.0 )
    }
    
    
    //活动地址
    func addAddress() {
        self.view.addSubview(activityAddressLabel)
        self.view.addSubview(activityAddressText)
        
        activityAddressLabel.sizeToFit()
        activityAddressLabel.text = "活动地址:"
        activityAddressLabel.textAlignment = NSTextAlignment.Right
        activityAddressLabel.snp_makeConstraints(closure: { make in
            make.top.equalTo(activityStarttimeLabel.snp_bottom).offset(10)
            make.width.equalTo(73)
            make.left.equalTo(20)
        })
        
        activityAddressText.placeholder = "请输入活动地址"
        activityAddressText.snp_makeConstraints(closure: { make in
            make.top.equalTo(activityStarttimeLabel.snp_bottom).offset(10)
            make.left.equalTo(activityAddressLabel.snp_right).offset(5)
            make.right.equalTo(-20)
        })
        activityAddressText.backgroundColor = UIColor ( red: 0.5216, green: 0.8314, blue: 1.0, alpha: 1.0 )
    }
    
    
    func initApplyButton() {
        self.view.addSubview(applyButton)
        applyButton.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(-80)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        let addTapButton = UITapGestureRecognizer(target: self, action: #selector(AddDelActivityViewController.tapApplyButton))
        applyButton.addGestureRecognizer(addTapButton)
        applyButton.setTitle("确定", forState: .Normal)
        applyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        applyButton.backgroundColor = UIColor.blackColor()
    }
    
    func tapAddButton() {
        let actionSheet = UIActionSheet(title: "选择图片",
                                        delegate: nil,
                                        cancelButtonTitle: "取消",//0
            destructiveButtonTitle: nil, //2
            otherButtonTitles: "照相机","照片库" ) //1,2
        actionSheet.rac_buttonClickedSignal().subscribeNext { [weak self](buttonIndex) -> Void in
            if buttonIndex.integerValue == 0 {
                return
            }
            let imagePickController = UIImagePickerController()
            imagePickController.allowsEditing = true //UIImagePickerControllerSourceType
            imagePickController.sourceType = buttonIndex.integerValue == 1 ? .Camera : .PhotoLibrary
            imagePickController.delegate = self
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self?.presentViewController(imagePickController, animated: true, completion: nil)
            })
        }
        actionSheet.showInView(self.view)
    }
    
    //点击确定
    func tapApplyButton() {
        let dataFormat = NSDateFormatter()
        dataFormat.dateFormat = "yyyy-MM-dd"
        starttime = dataFormat.stringFromDate(datePicker.date)
        activityStarttimeText.text = starttime
        
        if activityNameText.text == "" || activityAddressText.text == "" {
            ToastInfo("活动信息必须填写!")
            return
        }
        
        print("name = \(activityNameText.text)")
        print("address = \(activityAddressText.text)")
        
        if Image.image == nil {
            ToastInfo("必须为活动添加一张海报!")
            return
        }
        
        showHud("正在添加...")
        addAc.getData(activityNameText.text!, activityTime: starttime, activityAddress: activityAddressText.text!, activityCover: string)
    }
}

extension AddDelActivityViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            Image.image = image
            Image.hidden = false
        }
        
        let dataFormart = NSDateFormatter()
        dataFormart.dateFormat = "yyyy-MM-dd-hh-MM-ss"
        string = dataFormart.stringFromDate(NSDate())
        
        if Image.image == nil {
            string = ""
        } else {
            if saveImage(Image.image!, fileName: string) {
                print("存放成工!")
            } else {
                print("存放失败!")
            }
        }
    }
}

extension AddDelActivityViewController : AddActivityMe {
    
    func csuccess(userInfo: [Int]) {
        var isSuccess = false
        
        userInfo.forEach({
            if $0 == 1 {
                isSuccess = true
                return
            }
        })
        
        if isSuccess {
            popHud()
            upLoadImageActivity(string)
        } else {
            popHud()
            ToastInfo("操作失败，请重试!")
        }
        
    }
    
    func cerror() {
        popHud()
        ToastInfo("网络错误")
    }
}


func upLoadImageActivity(imageName: String) {
    print("imageName = \(imageName)")
    
    guard let data = getImageData(imageName) else {
        return
    }
    
    let request = Alamofire.upload(.POST, "http://\(UserLonInInfo.sharedInstance.ip):8080/ColorsTripServ/servlet/GetActivityImage", headers: ["name": imageName], data: data)
    print("request = \(request)")
    
}




/*
 //    func addActivityToTable() {
 //        let dataFormart = NSDateFormatter()
 //        dataFormart.dateFormat = "yyyy-MM-dd-hh-MM-ss"
 //        var string = dataFormart.stringFromDate(NSDate())
 //        string += activityNameText.text!
 //
 //        }
 //    }

 
 //        addActivityToTable()
 
 let database = FMDatabase(path: path().path)
 if database.open() {
 do {
 print("name = \(activityNameText.text!)")
 print("address = \(activityStarttimeText.text!)")
 print("address = \(activityAddressText.text!)")
 try database.executeUpdate("insert into activitytable (acname, actime, acaddress, accover) values (?, ?, ?, ?)", values: [activityNameText.text!,activityStarttimeText.text!,activityAddressText.text!,string])
 ToastInfo("操作成功!")
 } catch {
 print("插入失败!")
 }
 
 } else {
 print("打开数据库失败!")
 }
 database.close()
 */

