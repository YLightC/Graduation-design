//
//  ViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/11.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import SnapKit
import Toast
import FMDB

class ViewController: UIViewController{
    
    var ipText = UITextField()
    let logButton = UIButton(frame: CGRect())
    let idLabel = UILabel(frame: CGRect())
    let passwordLabel = UILabel(frame: CGRect())
    let idTextFiled = UITextField(frame: CGRect())
    let passwordTextFiled = UITextField(frame: CGRect())
    let width = UIScreen.mainScreen().bounds.width / 2
    let height = UIScreen.mainScreen().bounds.height
    var pressButton = false
    var buttonOne = UIButton()
    var buttonTwo = UIButton()
    var userLabel1 = UILabel()
    var userLabel2 = UILabel()
    var userInfo : [LogMessage] = []
    
    let getLog = GetSensitiveWords()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let formart = NSDateFormatter()
        formart.dateFormat = "yyyy-MM-dd hh-MM-ss"
        let string = formart.stringFromDate(NSDate())
        print("string = \(string)")
        getLog.delegate = self
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController {
    func initView() {
        self.navigationController?.navigationBar.hidden = true
        self.view.addSubview(ipText)
        self.view.addSubview(logButton)
        self.view.addSubview(idLabel)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(idTextFiled)
        self.view.addSubview(passwordTextFiled)
        self.view.addSubview(buttonOne)
        self.view.addSubview(buttonTwo)
        self.view.addSubview(userLabel1)
        self.view.addSubview(userLabel2)
        idTextFiled.keyboardType = .PhonePad
        passwordTextFiled.keyboardType = .NamePhonePad
        passwordTextFiled.delegate = self
        addIpText()
        addLogButton()
        addIdLabel()
        addPasswordLabel()
        addIdTextFiled()
        addPassWordTextFiled()
        addButtons()
        let tapView = UITapGestureRecognizer(target: self, action: "tapView")
        self.view.addGestureRecognizer(tapView)
        
    }
    
    func addIpText() {
        ipText.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(64)
            make.height.equalTo(30)
            make.width.equalTo(200)
        })
        ipText.layer.borderWidth = 0.5
        ipText.layer.borderColor = UIColor.brownColor().CGColor
        ipText.placeholder = "请输入ip"
    }
    
    func addLogButton() {
        logButton.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(-200)
            make.width.equalTo(width)
            make.left.equalTo(width / 2)
        })
        logButton.backgroundColor = UIColor.blueColor()
        logButton.setTitle("登录", forState: .Normal)
        logButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let tapButton = UITapGestureRecognizer(target: self, action: "tapButton")
        logButton.addGestureRecognizer(tapButton)
    }
    
    func addIdLabel() {
        idLabel.text = "账   号："
        idLabel.textColor = UIColor.blackColor()
        idLabel.sizeToFit()
        idLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(height / 3)
            make.left.equalTo(50)
        })
    }
    
    func addPasswordLabel() {
        passwordLabel.text = "密   码:"
        passwordLabel.textColor = UIColor.blackColor()
        passwordLabel.sizeToFit()
        passwordLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(height / 2)
            make.left.equalTo(50)
        })
    }
    
    func addIdTextFiled() {
        idTextFiled.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(idLabel)
            make.right.equalTo(-50)
            make.height.equalTo(30)
            make.width.equalTo(200)
        })
        idTextFiled.layer.borderWidth = 0.5
        idTextFiled.layer.borderColor = UIColor.brownColor().CGColor
        idTextFiled.placeholder = "请输入帐号"
    }
    
    func addPassWordTextFiled() {
        passwordTextFiled.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(passwordLabel)
            make.right.equalTo(-50)
            make.height.equalTo(30)
            make.width.equalTo(200)
        })
        passwordTextFiled.layer.borderWidth = 0.5
        passwordTextFiled.layer.borderColor = UIColor.brownColor().CGColor
        passwordTextFiled.placeholder = "请输入密码"
        passwordTextFiled.secureTextEntry = true
    }
    
    func addButtons() {
        buttonOne.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(-150)
            make.left.equalTo(50)
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        buttonOne.setBackgroundImage(UIImage(named: "1"), forState: .Normal)
        let tapOne = UITapGestureRecognizer(target: self, action: "tapOne")
        buttonOne.addGestureRecognizer(tapOne)
        buttonTwo.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(-150)
            make.right.equalTo(-150)
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        buttonTwo.setBackgroundImage(UIImage(named: "0"), forState: .Normal)
        let tapTwo = UITapGestureRecognizer(target: self, action: "tapTwo")
        buttonTwo.addGestureRecognizer(tapTwo)
        
        userLabel1.text = "普通员工"
        userLabel2.text = "管理员"
        userLabel1.textColor = UIColor.blackColor()
        userLabel2.textColor = UIColor.blackColor()
        userLabel1.sizeToFit()
        userLabel2.sizeToFit()
        
        userLabel1.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(90)
            make.centerY.equalTo(buttonOne)
        })
        
        userLabel2.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-80)
            make.centerY.equalTo(buttonTwo)
        })
    }
    
    func tapButton() {
//        getUserInfo()
//        logIn()
        guard let ip = ipText.text else {
            return
        }
        
        UserLonInInfo.sharedInstance.ip = ip
        showHud("正在登录...")
        getLog.getData()
    }
    
    
    func logIn() {
        guard let id = idTextFiled.text, let pwd = passwordTextFiled.text else {
            return
        }
        let getId = GetId()
        getId.delegate = self
        
        if !pressButton {
            var isSure = false
            userInfo.forEach({
                if $0.id == id && $0.pwd == pwd && $0.isAdm == 0 {
                    isSure = true
                    UserLonInInfo.sharedInstance.id = $0.id
                    UserLonInInfo.sharedInstance.pwd = $0.pwd
                    UserLonInInfo.sharedInstance.isAdm = "\($0.isAdm)"
                    UserLonInInfo.sharedInstance.headphoto = $0.headphoto
                    UserLonInInfo.sharedInstance.name = $0.name
                    return
                }
            })
            if isSure {
                popHud()
                getId.UserId()
                let userController = UserViewController()
                
                self.presentViewController(userController, animated: true, completion: nil)
            } else {
                
                ToastInfo("登录失败，密码或帐号错误!")
                popHud()
            }
        } else {
            var isSure = false
            userInfo.forEach({
                if $0.id == id && $0.pwd == pwd && $0.isAdm == 1 {
                    isSure = true
                    UserLonInInfo.sharedInstance.id = $0.id
                    UserLonInInfo.sharedInstance.pwd = $0.pwd
                    UserLonInInfo.sharedInstance.isAdm = "\($0.isAdm)"
                    UserLonInInfo.sharedInstance.headphoto = $0.headphoto
                    UserLonInInfo.sharedInstance.name = $0.name
                    return
                }
            })
            if isSure {
                popHud()
                getId.UserId()
                let admController = AdmViewController()
                self.presentViewController(admController, animated: true, completion: nil)
            } else {
                ToastInfo("登录失败，密码或帐号错误!")
                popHud()
            }
        }
    }
    
    func tapView() {
        idTextFiled.resignFirstResponder()
        passwordTextFiled.resignFirstResponder()
    }
    
    func tapOne() {
        pressButton = false
        buttonOne.setBackgroundImage(UIImage(named: "1"), forState: .Normal)
        buttonTwo.setBackgroundImage(UIImage(named: "0"), forState: .Normal)
    }
    
    func tapTwo() {
        pressButton = true
        buttonTwo.setBackgroundImage(UIImage(named: "1"), forState: .Normal)
        buttonOne.setBackgroundImage(UIImage(named: "0"), forState: .Normal)
    }
}

extension ViewController : UITextFieldDelegate,GetIdDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func sendId(inout userId: String) {
        userId = idTextFiled.text!
    }
}

func path() -> NSURL {
    let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
    let fileURL = documents.URLByAppendingPathComponent("test.sqlite")
    
    return fileURL
}


extension ViewController : LogMe {
    
    func success(userInfo :[LogMessage]) {
        popHud()
        self.userInfo = userInfo
        print("\(#function)")
        logIn()
    }
    
    func error() {
        popHud()
        print("\(#function)")
        ToastInfo("网络错误!")
    }
}



/*
 
 func getUserInfo() {
 userInfo.removeAll()
 let database = FMDatabase(path: path().path)
 print("datebase = \(path().path)")
 if database.open() {
 print("打开成功!")
 do {
 //                try database.executeUpdate("create table activitytable(acname text primary key, actime text, acaddress text, accover)", values: nil)
 //                try database.executeUpdate("create table usertable(id text primary key, psw text, status text)", values: nil)
 //                try database.executeUpdate("insert into usertable (id, psw, status) values (?, ?, ?)", values: ["2012020186","123456789","1"])
 //                try database.executeUpdate("delete from usertable where id=?", values: ["2012020186"])
 //                try database.executeUpdate("create table userinfo(id text primary key, name text, sex text, phone text, address text, headphoto text)", values: nil)
 //                try database.executeUpdate("insert into userinfo (id, name, sex, phone, address, headphoto) values (?, ?, ?, ?, ?, ?)", values: ["2012020186","姚驷旭","男","15877347757","陕西省周至县"," "])
 //                try database.executeUpdate("update usertable set status=? where id=?", values: ["1","2012020186"])
 //                try database.executeUpdate("create table leavetable(id text, name text, starttime text, endtime text, numberDays text, type text, typeInfo text, photo text, status text,location text)", values: nil)
 //                try database.executeUpdate("drop table activityTable", values: nil)
 let rs = try database.executeQuery( "select id, psw, status from usertable", values: nil)
 while rs.next() {
 let id = rs.stringForColumn("id")
 let pwd = rs.stringForColumn("psw")
 let status = rs.stringForColumn("status")
 var dic = Dictionary<String,String>()
 dic["id"] = id
 dic["pwd"] = pwd
 dic["status"] = status
 print("dic = \(dic)")
 userInfo.append(dic)
 }
 } catch {
 ToastInfo("操作失败!")
 }
 
 } else {
 ToastInfo("操作失败!")
 }
 database.close()
 }
 }
 */
