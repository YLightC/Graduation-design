//
//  UerLeaveViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/18.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class UerLeaveViewController: UIViewController {

    var userLeave = DisLeaveInfo()
    let typeLabel = UILabel(frame: CGRect())
    let typeInfo = UITextField(frame: CGRect())
    let image = UIImageView(frame: CGRect())
    let locationName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "请假详情"
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.hidden = true
        initUi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func initUi() {
        initTypeLabel()
        initTypeInfo()
        initImage()
        addLocationName()
    }
    
    func initTypeLabel() {
        typeLabel.text = "请假原因:"
        typeLabel.font = LHFont(20)
        self.view.addSubview(typeLabel)
        typeLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(5)
            make.left.equalTo(20)
        })
    }
    
    func initTypeInfo() {
        typeInfo.font = LHFont(15)
        typeInfo.text = userLeave.reson
        typeInfo.enabled = false
        self.view.addSubview(typeInfo)
        typeInfo.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(typeLabel.snp_bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        })
        typeInfo.layer.borderWidth = 0.5
        typeInfo.layer.borderColor = UIColor.orangeColor().CGColor
    }
    
    func initImage() {
        self.view.addSubview(image)
        image.clipsToBounds = true
        image.contentMode = .ScaleAspectFill
//        image.image = getImage(userLeave["photo"]!)
        image.image = UIImage(named: userLeave.proofMaterial)
        image.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(typeInfo.snp_bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-20)
            make.bottom.equalTo(-50)
        })
    }
    
    func addLocationName() {
        self.view.addSubview(locationName)
        locationName.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(image.snp_bottom).offset(10)
            make.width.equalTo(UIScreen.mainScreen().bounds.width)
            make.centerX.equalTo(self.view)
        })
        locationName.textAlignment = .Center
        locationName.text = "申请位置 :"
//        guard let location = userLeave["location"] else {
//            return
//        }
        print("location = \(userLeave.location)")
        locationName.text = "申请位置 :" + userLeave.location
    }
    
}
