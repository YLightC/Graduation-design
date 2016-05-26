//
//  WillCheckTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/2/2.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
//经过审核
class WillCheckTableViewCell: UITableViewCell {

    @IBOutlet var Name: UILabel!
    @IBOutlet var Type: UILabel!
    @IBOutlet var StartTime: UILabel!
    @IBOutlet var EndTime: UILabel!
    @IBOutlet var Status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
        // Initialization code
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
        Status.font = LHFont(15)
        Status.textAlignment = NSTextAlignment.Center
        Status.text = "审核状态"
        Status.textColor = UIColor.redColor()
    }

    
}

