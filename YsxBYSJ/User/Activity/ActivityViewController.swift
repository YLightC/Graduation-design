//
//  ActivityViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/13.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Toast
import Alamofire

class ActivityViewController: UIViewController {

    let button = UIButton(frame: CGRect())
    let Image = UIImageView(frame: CGRect())
    let resonTitle = UILabel(frame: CGRect())
    let resonInfo = UITextView(frame: CGRect())
    let fileTitle = UILabel(frame: CGRect())
    let applyButton = UIButton(frame: CGRect())
    let type = UILabel(frame: CGRect())
    let typeInfo = UITextField(frame: CGRect())
    var userid = ""
    var chooseTime = UIButton(frame: CGRect())
    static var startTime = ""
    static var endTime = ""
    static var numberDays = ""
    var isRun = false
    let userLeave = UserLeaveInfoM()
    var string = ""
    
    init(userid :String) {
        super.init(nibName: nil, bundle: nil)
        self.userid = userid
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLeave.delegate = self
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "管理"
        self.automaticallyAdjustsScrollViewInsets = false
        initType()
        initChhooseTimeButton()
        initTypeInfo()
        initResonTitle()
        initResonInfo()
        initFileTitle()
        initImageView()
        initButton()
        initApplyButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initChhooseTimeButton() {
        self.view.addSubview(chooseTime)
        chooseTime.snp_makeConstraints(closure: { (make) in
            make.center.equalTo(type)
            make.right.equalTo(-20)
            make.width.equalTo(100)
        })
        chooseTime.backgroundColor = UIColor.blackColor()
        chooseTime.setTitle("选择时间", forState: .Normal)
        chooseTime.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let choose = UITapGestureRecognizer(target: self, action: "chooseButton")
        chooseTime.addGestureRecognizer(choose)
    }
    
    func chooseButton() {
        self.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(ChooseTimeViewController(startTime: &self.startTime, endTime: &self.endTime, numberDays: &self.numberDays), animated: true)
        self.navigationController?.pushViewController(ChooseTimeViewController(), animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func initType() {
        self.view.addSubview(type)
        type.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(74)
            make.left.equalTo(20)
        })
        type.text = "类型(如:病假、事假)"
    }
    
    func initTypeInfo() {
        self.view.addSubview(typeInfo)
        typeInfo.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(type.snp_bottom).offset(20)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(30)
        })
        typeInfo.textColor = LHTextColor()
        typeInfo.font = LHFont(12)
        typeInfo.layer.borderWidth = 0.5
        typeInfo.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func initResonTitle() {
        self.view.addSubview(resonTitle)
        resonTitle.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(154)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        })
        resonTitle.textColor = UIColor.blackColor()
        resonTitle.font = LHFont(15)
        resonTitle.text = "请假理由"
        resonTitle.sizeToFit()
    }
    
    func initResonInfo() {
        self.view.addSubview(resonInfo)
        let size = resonTitle.sizeThatFits(CGSize(width: UIScreen.mainScreen().bounds.width, height: CGFloat(MAXFLOAT)))
        resonInfo.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(resonTitle).offset(size.height + 10)
            make.width.equalTo(UIScreen.mainScreen().bounds.width - 60)
            make.height.equalTo(100)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        })
        resonInfo.textColor = LHTextColor()
        resonInfo.font = LHFont(12)
        resonInfo.layer.borderWidth = 0.5
        resonInfo.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func initFileTitle() {
        self.view.addSubview(fileTitle)
        fileTitle.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(300)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        })
        fileTitle.text = "证明材料（如果有,仅限图片）"
        fileTitle.textColor = UIColor.blackColor()
        fileTitle.font = LHFont(15)
        fileTitle.sizeToFit()
    }
    
    func initButton() {
        self.view.addSubview(button)
        let size = fileTitle.sizeThatFits(CGSize(width: UIScreen.mainScreen().bounds.width, height: CGFloat(MAXFLOAT)))
        button.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(fileTitle)
            make.left.equalTo(fileTitle).offset(size.width + 20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        let addTapButton = UITapGestureRecognizer(target: self, action: "tapAddButton")
        button.addGestureRecognizer(addTapButton)
        button.setBackgroundImage(UIImage(named: "矩形-35"), forState: .Normal)
    }
    
    func initImageView() {
        self.view.addSubview(Image)
        Image.clipsToBounds = true
        Image.contentMode = .ScaleAspectFill
        let size = fileTitle.sizeThatFits(CGSize(width: UIScreen.mainScreen().bounds.width, height: CGFloat(MAXFLOAT)))
        Image.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(fileTitle).offset(size.height + 10)
            make.bottom.equalTo(-150)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        })
        Image.hidden = true
    }
    
    func tapAddButton() {
        resonInfo.resignFirstResponder()
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
    
    func initApplyButton() {
        self.view.addSubview(applyButton)
        applyButton.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(-80)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
        let addTapButton = UITapGestureRecognizer(target: self, action: "tapApplyButton")
        applyButton.addGestureRecognizer(addTapButton)
        applyButton.setTitle("提交", forState: .Normal)
        applyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        applyButton.backgroundColor = UIColor.blackColor()
    }
    
    func tapApplyButton() {
        if ActivityViewController.startTime == "" || ActivityViewController.endTime == "" || ActivityViewController.numberDays == "" {
            let style = CSToastStyle(defaultStyle: ())
            style.messageColor = UIColor.orangeColor()
            self.view.makeToast("请时间必须填写!", duration: 1, position: CSToastPositionCenter, style: style)
            return
        }
        
        if typeInfo.text == nil || typeInfo.text == "" || resonInfo.text == nil || resonInfo.text == "" {
            let style = CSToastStyle(defaultStyle: ())
            style.messageColor = UIColor.orangeColor()
            self.view.makeToast("请假类型和原因不能为空!", duration: 1, position: CSToastPositionCenter, style: style)
            return
        }
        showHud("正在定位请稍等!")
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.startLocation()
    }
    
}

extension ActivityViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            Image.image = image
            Image.hidden = false
            string = UserLonInInfo.sharedInstance.id
            let dataFormart = NSDateFormatter()
            dataFormart.dateFormat = "yyyy-MM-dd-hh-MM-ss"
            string += dataFormart.stringFromDate(NSDate())
            
            if Image.image == nil {
                string = ""
            } else {
                if saveImage(Image.image!, fileName: string) {
                    print("存放成工!")
                } else {
                    print("存放失败!")
                }
            }
            saveImage(Image.image!,fileName: string)
        }
    }
}

extension ActivityViewController: GetLocation {
 
    func getLocation(location: String) {
        if !isRun {
            showHud("提交信息中")
            guard let numbers = Int.init(ActivityViewController.numberDays) else {
                return
            }
            
            userLeave.getData(UserLonInInfo.sharedInstance.id, name: UserLonInInfo.sharedInstance.name, starttime: ActivityViewController.startTime, endtime: ActivityViewController.endTime, numberDays: numbers, type: "0", reson: typeInfo.text!, proofMaterial: string, location: location, leaveMessage: resonInfo.text!)
        }
        isRun = true
    }
    
    func getLocationError() {
        popHud()
        ToastInfo("定位出错!")
    }
}

extension ActivityViewController : UserLeaveInfoMe {
    
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
            ToastInfo("操作成功!")
            isRun = false
            upLoadImageLeave(string)
        } else {
            popHud()
            ToastInfo("操作失败，请重试!")
        }
        
    }
    
    func cerror() {
        popHud()
        ToastInfo("网络出错")
    }
}


func upLoadImageLeave(imageName: String) {
    print("imageName = \(imageName)")
    
    guard let data = getImageData(imageName) else {
        return
    }
    
    let request = Alamofire.upload(.POST, "http://\(UserLonInInfo.sharedInstance.ip):8080/ColorsTripServ/servlet/GetUserLeaveImage", headers: ["name": imageName], data: data)
    print("request = \(request)")
    
}



/*
 func insertData(locationName: String) {
 var name = ""
 let database = FMDatabase(path: path().path)
 if database.open() {
 do {
 let rs = try database.executeQuery( "select name from userinfo where id=?", values: [userid])
 while rs.next() {
 name = rs.stringForColumn("name")
 }
 let dataFormart = NSDateFormatter()
 dataFormart.dateFormat = "yyyy-MM-dd-hh-MM-ss"
 var string = dataFormart.stringFromDate(NSDate())
 
 if Image.image == nil {
 string = ""
 } else {
 //                    if saveImage(Image.image!, fileName: string) {
 //                        print("存放成工!")
 //                    } else {
 //                        print("存放失败!")
 //                    }
 }
 
 try database.executeUpdate("insert into leavetable (id, name, starttime, endtime, numberDays, type, typeInfo, photo, status,location) values (?, ?, ?, ?, ?, ?, ?, ?, ?,?)", values: [userid,name,ActivityViewController.startTime,ActivityViewController.endTime,ActivityViewController.numberDays,typeInfo.text!,resonInfo.text!,string,"0",locationName])
 
 } catch {
 print("插入失败!")
 }
 
 } else {
 print("打开数据库失败!")
 }
 ToastInfo("操作成功!")
 ActivityViewController.startTime = ""
 ActivityViewController.endTime = ""
 typeInfo.text = nil
 resonInfo.text = nil
 database.close()
 }
 */
