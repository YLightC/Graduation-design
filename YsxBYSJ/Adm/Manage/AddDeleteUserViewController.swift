//
//  AddDeleteUserViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/5.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Toast

class AddDeleteUserViewController: UIViewController {

    let tableView = UITableView(frame: CGRect())
    let cellIdentifier = "AddDeleteTableViewCell"
    let AddButton = UIButton()
    let DeleteButton = UIButton()
    var userId : String?
    var userName : String?
    var userSex : String?
    var userPhone : String?
    var userAddress : String?
    var userHeadPhoto : String?
   
    let add = AddUserM()
    let delete = deleteUserM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add.delegate = self
        delete.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = LHBackGroundColor()
        initTableView()
        addButton()
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
        tableView.backgroundColor = LHBackGroundColor()
        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-150)
        })
        
        let headView = UIView(frame: CGRect(x: 0, y: 61, width: UIScreen.mainScreen().bounds.width, height: 60))
        headView.backgroundColor = LHBackGroundColor()
        let infoLabel = UILabel(frame: CGRect())
        headView.addSubview(infoLabel)
        infoLabel.textColor = UIColor ( red: 0.0667, green: 0.6275, blue: 0.7451, alpha: 1.0 )
        infoLabel.text = "提示信息：如果需要删除员工，只需填入该员工的员工ID"
        infoLabel.numberOfLines = 2
        infoLabel.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(headView)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        })
        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "AddDeleteTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func addButton() {
        self.view.addSubview(AddButton)
        self.view.addSubview(DeleteButton)
        AddButton.backgroundColor = UIColor.blackColor()
        DeleteButton.backgroundColor = UIColor.blackColor()
        AddButton.setTitle("增加", forState: .Normal)
        DeleteButton.setTitle("删除", forState: .Normal)
        AddButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        DeleteButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        AddButton.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(tableView.snp_bottom).offset(30)
            make.left.equalTo(40)
            make.width.equalTo(75)
            make.height.equalTo(30)
        })
        
        DeleteButton.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(tableView.snp_bottom).offset(30)
            make.right.equalTo(-40)
            make.width.equalTo(75)
            make.height.equalTo(30)
        })
        let addButton = UITapGestureRecognizer(target: self, action: "addUser")
        AddButton.addGestureRecognizer(addButton)
        let deleteButton = UITapGestureRecognizer(target: self, action: "deleteUser")
        DeleteButton.addGestureRecognizer(deleteButton)
        AddButton.layer.cornerRadius = 15
        AddButton.layer.masksToBounds = true
        DeleteButton.layer.cornerRadius = 15
        DeleteButton.layer.masksToBounds = true
    }
    
}

extension AddDeleteUserViewController : AddUserMe {
    
    func success(userInfo: [Int]) {
        var isSuccess = false
        
        userInfo.forEach({
            if $0 == 3 {
                isSuccess = true
                return
            }
        })
        
        if isSuccess {
            ToastInfo("增加成功!")
        } else {
            ToastInfo("添加失败!")
        }
        popHud()
    }
    
    func error() {
        popHud()
        ToastInfo("网络错误!")
    }
    
}

extension AddDeleteUserViewController : DeleteUserMe {
    
    func dsuccess(userInfo: [Int]) {
        var isSuccess = false
        
        userInfo.forEach({
            if $0 == 3 {
                isSuccess = true
                return
            }
        })
        
        if isSuccess {
            ToastInfo("删除成功!")
        } else {
            ToastInfo("删除失败!")
        }
        popHud()
    }
    
    func derror() {
        popHud()
        ToastInfo("网络错误!")
    }
}


extension AddDeleteUserViewController {
    
    func addUser() {
        showHud()
        if userId == "" || userName == "" || userSex == "" || userPhone == "" || userAddress == "" || userHeadPhoto == "" {
            popHud()
            ToastInfo("增加员工时，员工的所有信息必须填写!")
            return
        }
        
//        if userSex != "男" || userSex != "女" {
//            popHud()
//            ToastInfo("性别必须位男或女")
//            return
//        }
        
        guard let uid = userId else {
            return
        }
        
        guard let n = userName else {
            return
        }
        
        guard let s = userSex else {
            return
        }
        
        guard let addr = userAddress else {
            return
        }
        
        guard let phone = userPhone else {
            return
        }
        
        add.getData(uid, pwd: "123456789", isAdm: "0", headphoto: "", name: n, sex: s, address: addr, phoneNumber: phone)
        
//        let database = FMDatabase(path: path().path)
//        if database.open() {
//            do {
//                try database.executeUpdate("insert into usertable (id, psw, status) values (?, ?, ?)", values: [userId!,"123456789","0"])
//                try database.executeUpdate("insert into userinfo (id, name, sex, phone, address, headphoto) values (?, ?, ?, ?, ?, ?)", values: [userId!,userName!,userSex!,userPhone!,userAddress!,userPhone!])
//            } catch {
//                ToastInfo("添加员工失败!")
//            }
//        } else {
//            ToastInfo("添加员工失败!")
//        }
//        popHud()
//        database.close()
//        ToastInfo("添加员工成功!")
//        userId = ""
//        userName = ""
//        userSex = ""
//        userPhone = ""
//        userAddress = ""
//        userHeadPhoto = ""
    }
    
    func deleteUser() {
        showHud("删除中...")
        if userId == "" || userId == nil {
            popHud()
            ToastInfo("删除员工时，员工ID必须填写!")
            return
        }
        
        guard let id = userId else {
            return
        }
        
        delete.getData(id)
        
//
//        let database = FMDatabase(path: path().path)
//        if database.open() {
//            do {
//                try database.executeUpdate("delete from usertable where id=?", values: [userId!])
//                try database.executeUpdate("delete from userinfo where id=?", values: [userId!])
//            } catch {
//                ToastInfo("删除员工失败!")
//            }
//        } else {
//            ToastInfo("删除员工失败!")
//        }
//        popHud()
//        database.close()
//        ToastInfo("删除员工成功!")
//        userId = nil
    }
}



extension AddDeleteUserViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddDeleteTableViewCell
        cell.InfoTextFiled.delegate = self
        switch indexPath.row {
        case 0:
            cell.type.text = "员工号:"
            cell.InfoTextFiled.keyboardType = .PhonePad
            self.userId = cell.InfoTextFiled.text
        case 1:
            cell.type.text = "姓   名:"
            cell.InfoTextFiled.keyboardType = .Default
            self.userName = cell.InfoTextFiled.text
        case 2:
            cell.type.text = "性   别:"
            cell.InfoTextFiled.keyboardType = .Default
            self.userSex = cell.InfoTextFiled.text
        case 3:
            cell.type.text = "电   话:"
            cell.InfoTextFiled.keyboardType = .PhonePad
            self.userPhone = cell.InfoTextFiled.text
        default:
            cell.type.text = "住   址:"
            cell.InfoTextFiled.keyboardType = .Default
            self.userAddress = cell.InfoTextFiled.text
            self.userHeadPhoto = "   "
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
}

extension AddDeleteUserViewController : UITextFieldDelegate {
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        tableView.reloadData()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        tableView.reloadData()
    }    
}


