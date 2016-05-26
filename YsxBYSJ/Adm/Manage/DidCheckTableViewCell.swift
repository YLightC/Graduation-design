//
//  DidCheckTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/2/2.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

protocol DidCheckTableDelegate : class {
    func agreeButton(row :Int)
    func disAgreeButton(row :Int)
}

//未审核
class DidCheckTableViewCell: UITableViewCell {

    @IBOutlet var Name: UILabel!
    @IBOutlet var Type: UILabel!
    @IBOutlet var StartTime: UILabel!
    @IBOutlet var EndTime: UILabel!
    @IBOutlet var Agree: UIButton!
    @IBOutlet var NoAgree: UIButton!
    weak var delegate : DidCheckTableDelegate!
    var row = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .None
    }
    
    func initCell() {
        Name.font = LHFont(15)
        Name.textAlignment = NSTextAlignment.Center
        Name.text = "姓名"
        Type.font = LHFont(15)
        Type.textAlignment = NSTextAlignment.Center
        Type.text = "类型"
        StartTime.font = LHFont(15)
        StartTime.textAlignment = NSTextAlignment.Center
        StartTime.text = "起始时间"
        EndTime.font = LHFont(15)
        EndTime.textAlignment = NSTextAlignment.Center
        EndTime.text = "终止时间"
        Agree.setTitle("同意", forState: .Normal)
        Agree.setTitleColor(UIColor ( red: 0.098, green: 0.5922, blue: 0.7451, alpha: 1.0 ), forState: .Normal)
        Agree.backgroundColor = UIColor.clearColor()
        let agreeButton = UITapGestureRecognizer(target: self, action: "AgreeAction")
        Agree.addGestureRecognizer(agreeButton)
        
        
        NoAgree.setTitle("否决", forState: .Normal)
        NoAgree.setTitleColor(UIColor ( red: 0.098, green: 0.5922, blue: 0.7451, alpha: 1.0 ), forState: .Normal)
        NoAgree.backgroundColor = UIColor.clearColor()
        let NoAgreeButton = UITapGestureRecognizer(target: self, action: "NoAgreeAction")
        NoAgree.addGestureRecognizer(NoAgreeButton)

    }
    
    
    func AgreeAction() {
        delegate.agreeButton(row)
    }
    
    func NoAgreeAction() {
        delegate.disAgreeButton(row)
    }
    
    
}
