//
//  SearchTableViewCellTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/24.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class SearchTableViewCellTableViewCell: UITableViewCell {
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
        startTime.font = LHFont(11)
        startTime.textColor = LHTextColor()
        endTime.font = LHFont(11)
        endTime.textColor = LHTextColor()
        reson.font = LHFont(10)
        reson.textColor = LHTextColor()
        status.font = LHFont(14)
        status.textColor = UIColor.redColor()
    }
    
}
