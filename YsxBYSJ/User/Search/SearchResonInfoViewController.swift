//
//  SearchResonInfoViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/24.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class SearchResonInfoViewController: UIViewController {

    let resonTitle = UILabel(frame: CGRect())
    let resonInfo = UILabel(frame: CGRect())
    let fileTitle = UILabel(frame: CGRect())
    let fileImage = UIImageView(frame: CGRect())
    var userLeave = DisLeaveInfo()
    var locationName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "请假原因"
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        self.view.addSubview(resonTitle)
        self.view.addSubview(resonInfo)
        self.view.addSubview(fileTitle)
        self.view.addSubview(fileImage)
        addResonTiltle()
        addResonInfo()
        addFileTitle()
        addFileImage()
        addLocationName()
    }
    
    func addResonTiltle() {
        resonTitle.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(74)
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.height.equalTo(30)
        })
        resonTitle.text = "请假原因"
        resonTitle.sizeToFit()
        resonTitle.font = LHFont(20)
        resonTitle.textColor = UIColor.blackColor()
    }
    
    func addResonInfo() {
        resonInfo.enabled = false
        resonInfo.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(resonTitle.snp_bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        })
        resonInfo.layer.borderWidth = 0.5
        resonInfo.layer.borderColor = UIColor.blackColor().CGColor
        resonInfo.textColor = LHTextColor()
        resonInfo.text = userLeave.leaveMessage
        resonInfo.font = LHFont(15)
        resonInfo.lineBreakMode = NSLineBreakMode.ByWordWrapping
        resonInfo.numberOfLines = 0
        resonInfo.sizeToFit()
    }
    
    func addFileTitle() {
        fileTitle.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(resonInfo.snp_bottom).offset(40)
            make.left.equalTo(20)
        })
        fileTitle.text = "证明材料，仅限照片"
        fileTitle.sizeToFit()
        fileTitle.font = LHFont(20)
        fileTitle.textColor = UIColor.blackColor()
    }
    
    func addFileImage() {
        fileImage.clipsToBounds = true
        fileImage.contentMode = .ScaleAspectFill
        fileImage.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(fileTitle.snp_bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-50)
        })
        fileImage.clipsToBounds = true
        fileImage.contentMode = .ScaleAspectFill
//        guard let image = getImage(userLeave["photo"]!) else {
//            print("照片为空!")
//            return
//        }
        fileImage.lh_setImageWithURL(userLeave.proofMaterial, placeholderImage: UIImage(named: ""))
//        fileImage.image = UIImage(named: userLeave.proofMaterial)
    }
    
    func addLocationName() {
        self.view.addSubview(locationName)
        locationName.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(fileImage.snp_bottom).offset(10)
            make.width.width.equalTo(UIScreen.mainScreen().bounds.width)
            make.centerX.equalTo(self.view)
        })
        locationName.textAlignment = .Center
        locationName.text = "申请位置 :" + userLeave.location
//        guard let location = userLeave.location else {
//            return
//        }
        
        
        print("location = \(userLeave.location)")
        locationName.text = "申请位置 :" + userLeave.location
    }
    
}
