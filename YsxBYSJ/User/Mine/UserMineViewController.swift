//
//  MineViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/13.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Toast
import Alamofire

class UserMineViewController: UIViewController {
    
    let tableView = UITableView()
    let mineIdentifier = "UserMineTableViewCell"
    let infoIdentifier = "UserMineInfoTableViewCell"
    var userid = ""
    var id = ""
    var name = ""
    var sex = ""
    var phone = ""
    var address = ""
    var headphoto = ""
    let changeUser = ChangeUserHeadphotoM()
    var string = ""
    
    var userInfo = DisUserInfo()

    init(userid :String) {
        super.init(nibName: nil, bundle: nil)
        self.userid = userid
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHud("正在加载数据...")
        userInfo.id = self.userid
        changeUser.delegate = self
        UserInfo.sharedInstance.delegate = self
        UserInfo.sharedInstance.getData()
        self.navigationItem.title = "我"
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.view.backgroundColor = LHBackGroundColor()
        initTableView()
//        initGetData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
    
    func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(64)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        })
        tableView.delegate = self
        tableView.dataSource = self
        var cellNib = UINib(nibName: "UserMineTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: mineIdentifier)
        cellNib = UINib(nibName: "UserMineInfoTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: infoIdentifier)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UITableView()
    }
}

extension UserMineViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 10))
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(mineIdentifier, forIndexPath: indexPath) as! UserMineTableViewCell
            cell.id.text = self.userid
            cell.name.text = self.userInfo.name
//            if getImage(headphoto) != nil {
                cell.headImage.lh_setImageWithURL(UserLonInInfo.sharedInstance.headphoto, placeholderImage: UIImage(named: "find_musician"))
//            }
            
            cell.headImage.userInteractionEnabled = true
            let headImageAction = UITapGestureRecognizer(target: self, action: #selector(UserMineViewController.tapAddButton))
            cell.headImage.addGestureRecognizer(headImageAction)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(infoIdentifier, forIndexPath: indexPath) as! UserMineInfoTableViewCell
            if indexPath.row == 0 {
                cell.title.text = "性别"
                cell.info.text = self.userInfo.sex
            } else if indexPath.row == 1 {
                cell.title.text = "联系方式"
                cell.info.text = self.userInfo.phoneNumber
            } else {
                cell.title.text = "家庭住址"
                cell.info.text = self.userInfo.address
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(infoIdentifier, forIndexPath: indexPath) as! UserMineInfoTableViewCell
            cell.info.hidden = true
            cell.title.text = "设置"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 64
        } else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                self.hidesBottomBarWhenPushed = true
                let admSetVc = UserSetViewController()
                admSetVc.userid = self.userid
                self.navigationController?.pushViewController(admSetVc, animated: true)
                self.hidesBottomBarWhenPushed = false
            }
        }
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
    
    
}

extension UserMineViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! UserMineTableViewCell
            cell.headImage.image = image
            cell.headImage.hidden = false
            
            let dataFormart = NSDateFormatter()
            dataFormart.dateFormat = "yyyy-MM-dd-hh-MM-ss"
            string = dataFormart.stringFromDate(NSDate())
            
            if cell.headImage.image == nil {
                string = ""
            } else {
                string += userid
                if saveImage(cell.headImage.image!, fileName: string) {
                    print("存放成工!")
                } else {
                    print("存放失败!")
                }
            }
            cell.headImage.accessibilityIdentifier = string
            saveImage(cell.headImage.image!,fileName: string)
            showHud("修改中...")
            changeUser.getData(userid, headphoto: string)
//            upLoadImage(string)
        }
    }
}

extension UserMineViewController : ChangeUserHeadphotoMe {
    
    func csuccess(userInfo: [Int]) {
        
        var isSuccess = false
        
        userInfo.forEach({
            if $0 == 1 {
                isSuccess = true
                return
            }
        })
        
        if isSuccess {
            upLoadImage(string)
            popHud()
        } else {
            popHud()
            ToastInfo("网络错误")
        }
        
    }
    
    func cerror() {
        popHud()
        ToastInfo("网络错误!")
    }
    
}


extension UserMineViewController : UserInfoMe {
    
    func success(userInfo: [UserMessageItem]) {
        
        userInfo.forEach({
            if $0.id == self.userid {
                self.userInfo.address = $0.address
                self.userInfo.name = $0.name
                self.userInfo.phoneNumber = $0.phoneNumber
                self.userInfo.sex = $0.sex
                popHud()
                tableView.reloadData()
                return
            }
        })
    }
    
    func error() {
        popHud()
        ToastInfo("网络错误")
    }
    
}

func upLoadImage(imageName: String) {
    print("imageName = \(imageName)")
    
    guard let data = getImageData(imageName) else {
        return
    }

    let request = Alamofire.upload(.POST, "http://\(UserLonInInfo.sharedInstance.ip):8080/ColorsTripServ/servlet/GetUserImage", headers: ["name": imageName], data: data)
    print("request = \(request)")

}


/*
 //    let fileURL = NSBundle.mainBundle().URLForResource(imageName, withExtension: "png")
 
 //    Alamofire.upload(.POST, "http://192.168.191.8:8080/ColorsTripServ/servlet/GetUserImage", file: fileURL!)
 //    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [NSString]
 //    let filePath = paths[0].stringByAppendingPathComponent(imageName)
 //    let ss = NSHomeDirectory().stringByAppendingString("/Documents/")
 //    let url = NSURL(string: ss.stringByAppendingString(imageName.stringByAppendingString(".png")))
 //
 //    guard let ur = url else {
 //        return
 //    }
 //
 //    Alamofire.upload(.POST, "http://192.168.191.8:8080/ColorsTripServ/servlet/GetUserImage", file: ur)

//    Alamofire.upload(.POST, "http://192.168.191.8:8080/ColorsTripServ/servlet/GetUserImage", data: data)
 
 
 
 func initGetData() {
 let database = FMDatabase(path: path().path)
 showHud()
 if database.open() {
 
 do {
 let rs = try database.executeQuery("select id, name, sex, phone, address, headphoto from userinfo where id=?", values: [self.userid])
 while rs.next() {
 let id = rs.stringForColumn("id")
 let name = rs.stringForColumn("name")
 let sex = rs.stringForColumn("sex")
 let phone = rs.stringForColumn("phone")
 let address = rs.stringForColumn("address")
 let headphoto = rs.stringForColumn("headphoto")
 self.id = id
 print("sefl.id = \(self.id)")
 self.name = name
 print("sefl.name = \(self.name)")
 self.sex = sex
 print("sefl.sex = \(self.sex)")
 self.phone = phone
 print("sefl.phone = \(self.phone)")
 self.address = address
 print("sefl.address = \(self.address)")
 self.headphoto = headphoto
 print("sefl.headphoto = \(self.headphoto)")
 }
 tableView.reloadData()
 } catch {
 let style = CSToastStyle(defaultStyle: ())
 style.messageColor = UIColor.orangeColor()
 self.view.makeToast("获取数据失败", duration: 1, position: CSToastPositionCenter, style: style)
 }
 } else {
 let style = CSToastStyle(defaultStyle: ())
 style.messageColor = UIColor.orangeColor()
 self.view.makeToast("获取数据失败!", duration: 1, position: CSToastPositionCenter, style: style)
 }
 database.close()
 popHud()
 }
 
 
 
 
 func addImage(Image: UIImageView,imagePath: String) {
 let database = FMDatabase(path: path().path)
 
 if database.open() {
 do {
 try database.executeUpdate("update userinfo set headphoto=? where id=?", values: [imagePath,userid])
 } catch {
 print("插入失败!")
 }
 
 } else {
 print("打开数据库失败!")
 }
 ToastInfo("操作成功!")
 database.close()
 }

 
 
 
 */

