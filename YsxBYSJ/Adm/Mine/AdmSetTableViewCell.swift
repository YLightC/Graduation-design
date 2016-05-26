//
//  AdmTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class AdmSetTableViewCell: UITableViewCell {

    @IBOutlet var info: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Configure the view for the selected state
    }
    
    func initCell() {
        info.font = LHFont(20)
        info.textColor = UIColor.blackColor()
    }
    
}
