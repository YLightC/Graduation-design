//
//  NowTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/2/15.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class NowTableViewCell: UITableViewCell {
    @IBOutlet var Name: UILabel!
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var reson: UILabel!
    @IBOutlet var status: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .None
        // Configure the view for the selected state
    }
    
    func initCell() {
        Name.text = "Jaosn"
        Name.font = LHFont(16)
        Name.textAlignment = NSTextAlignment.Center
        startTime.text = "20160216"
        startTime.font = LHFont(16)
        startTime.textAlignment = NSTextAlignment.Center
        endTime.text = "20160231"
        endTime.font = LHFont(16)
        endTime.textAlignment = NSTextAlignment.Center
        reson.text = "事假"
        reson.font = LHFont(16)
        reson.textAlignment = NSTextAlignment.Center
        let string = Int.init(endTime.text!)! - Int.init(startTime.text!)!
        status.text = "\(string)"
        status.font = LHFont(16)
        status.textAlignment = NSTextAlignment.Center
    }
    
}
