//
//  SetNewPwdViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/5.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Toast

class SetNewPwdViewController: UIViewController {

    let onePwd = UITextField(frame: CGRect())
    let twoPwd = UITextField(frame: CGRect())
    let sureButton = UIButton(frame: CGRect())
    var userid = ""
    
    let change = ChangeM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        change.delegate = self
        let tapView = UITapGestureRecognizer(target: self, action: "tapViewAction")
        self.view.addGestureRecognizer(tapView)
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "设置新密码"
        self.automaticallyAdjustsScrollViewInsets = false
        initOnePwd()
        initTwoPwd()
        initSureButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initOnePwd() {
        self.view.addSubview(onePwd)
        onePwd.text = nil
        onePwd.secureTextEntry = true
        onePwd.placeholder = "请输入密码"
        onePwd.textColor = UIColor.blackColor()
        onePwd.font = LHFont(15)
        onePwd.borderStyle = .Line
        onePwd.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(150)
            make.centerX.equalTo(self.view)
            make.width.equalTo(UIScreen.mainScreen().bounds.width / 2)
            make.height.equalTo(25)
        })
    }
    
    func initTwoPwd() {
        self.view.addSubview(twoPwd)
        twoPwd.text = nil
        twoPwd.secureTextEntry = true
        twoPwd.placeholder = "请再次输入密码进行确认"
        twoPwd.textColor = UIColor.blackColor()
        twoPwd.font = LHFont(15)
        twoPwd.borderStyle = .Line
        twoPwd.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(onePwd).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(UIScreen.mainScreen().bounds.width / 2)
            make.height.equalTo(25)
        })
    }
    
    func initSureButton() {
        self.view.addSubview(sureButton)
        sureButton.setTitle("确认修改", forState: .Normal)
        sureButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureButton.backgroundColor = UIColor.blackColor()
        sureButton.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(twoPwd).offset(100)
            make.centerX.equalTo(self.view)
            make.width.equalTo(UIScreen.mainScreen().bounds.width / 3)
            make.height.equalTo(30)
        })
        sureButton.layer.cornerRadius = 15
        let sureAction = UITapGestureRecognizer(target: self, action: "sureButtonAction")
        sureButton.addGestureRecognizer(sureAction)
    }
    
    func tapViewAction() {
        onePwd.resignFirstResponder()
        twoPwd.resignFirstResponder()
    }
    
    func sureButtonAction() {
        
        showHud("修改中...")
        guard let one = onePwd.text,let two = twoPwd.text else {
            let style = CSToastStyle(defaultStyle: ())
            style.messageColor = UIColor.orangeColor()
            self.view.makeToast("密码不能为空!", duration: 1, position: CSToastPositionCenter, style: style)
            popHud()
            return
        }
        if one != two {
            let style = CSToastStyle(defaultStyle: ())
            style.messageColor = UIColor.orangeColor()
            self.view.makeToast("两次输入密码不一致，请重新输入!", duration: 1, position: CSToastPositionCenter, style: style)
            popHud()
            return
        }
        popHud()
        change.getData(userid, pwd: one)
        
//        let database = FMDatabase(path: path().path)
//        if database.open() {
//            do {
//                try database.executeUpdate("update usertable set psw=? where id=?", values: [one,self.userid])
//                popHud()
//                self.navigationController?.popViewControllerAnimated(true)
//            } catch {
//                let style = CSToastStyle(defaultStyle: ())
//                style.messageColor = UIColor.orangeColor()
//                self.view.makeToast("获取数据失败", duration: 1, position: CSToastPositionCenter, style: style)
//            }
//        } else {
//            let style = CSToastStyle(defaultStyle: ())
//            style.messageColor = UIColor.orangeColor()
//            self.view.makeToast("获取数据失败!", duration: 1, position: CSToastPositionCenter, style: style)
//        }
//        database.close()
//        popHud()
    }
}

extension SetNewPwdViewController : ChangePwdMe {
    
    func success(userInfo: [Int]) {
        print("userInfo = \(userInfo)")
        var isSuccess = false
        
        userInfo.forEach({
            if $0 == 1 {
                isSuccess = true
                return
            }
        })
        
        if isSuccess {
            ToastInfo("修改成功!")
            navigationController?.popToRootViewControllerAnimated(true)
        } else {
            ToastInfo("操作失败请重试!")
        }
    }
    
    func error() {
        popHud()
        ToastInfo("网络异常")
    }
    
}

