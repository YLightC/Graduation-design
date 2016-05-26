//
//  ChooseTimeViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import Toast

class ChooseTimeViewController: UIViewController {
    
    let startTimePicker = UIDatePicker(frame: CGRect())
    let endTimePicker = UIDatePicker(frame: CGRect())
    let startLabel = UILabel(frame: CGRect())
    let endLabel = UILabel(frame: CGRect())
    let sureButton = UIButton(frame: CGRect())
//    var startTime = ""
//    var endTime = ""
//    var numberDays = ""
//    let startTimeField = UITextField(frame: CGRect())
//    let endTimeField = UITextField(frame: CGRect())

    
//    init(inout startTime :String,inout endTime :String,inout numberDays :String) {
//        super.init(nibName: nil, bundle: nil)
//        self.startTime = startTime
//        self.endTime = endTime
//        self.numberDays = numberDays
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LHBackGroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
        initStartChooseTime()
        initStartTimePicker()
        initEndChooseTime()
        initEndTimePicker()
        initSureButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initStartChooseTime() {
        self.view.addSubview(startLabel)
        startLabel.text = "请选择开始时间:"
        startLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(70)
            make.left.equalTo(20)
        })
    }
    
    func initStartTimePicker() {
        startTimePicker.datePickerMode = .Date
        self.view.addSubview(startTimePicker)
        startTimePicker.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(startLabel.snp_bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        })
    }
    
    func initEndChooseTime() {
        self.view.addSubview(endLabel)
        endLabel.text = "请选择结束时间:"
        endLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(startTimePicker.snp_bottom).offset(20)
            make.left.equalTo(20)
        })
    }
    
    func initEndTimePicker() {
        endTimePicker.datePickerMode = .Date
        self.view.addSubview(endTimePicker)
        endTimePicker.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(endLabel.snp_bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        })
    }
    
    func initSureButton() {
        self.view.addSubview(sureButton)
        sureButton.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(endTimePicker.snp_bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerX.equalTo(self.view)
        })
        sureButton.backgroundColor = UIColor.blackColor()
        sureButton.setTitle("确定", forState: .Normal)
        sureButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let sureButtonAction = UITapGestureRecognizer(target: self, action: "sureButtonAction")
        sureButton.addGestureRecognizer(sureButtonAction)
    }
    
    func sureButtonAction() {
        let format = NSDateFormatter()
        let start = startTimePicker.date
        let end = endTimePicker.date
        format.dateFormat = "yyyy-MM-dd"
        ActivityViewController.numberDays = "\(daysBetween(date1: start, date2: end) + 1)"
        ActivityViewController.startTime = format.stringFromDate(start)
        ActivityViewController.endTime = format.stringFromDate(end)
        
        if ActivityViewController.startTime >= ActivityViewController.endTime {
            let style = CSToastStyle(defaultStyle: ())
            style.messageColor = UIColor.orangeColor()
            self.view.makeToast("开始时间大于结束时间，请重新选择!", duration: 1, position: CSToastPositionCenter, style: style)
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
