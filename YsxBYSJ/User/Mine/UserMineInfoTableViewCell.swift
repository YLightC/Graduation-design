//
//  UserMineInfoTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class UserMineInfoTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
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
        title.font = LHFont(15)
        title.textColor = UIColor.blackColor()
        
        info.font = LHFont(14)
        info.textColor = theTheme().textColor
    }
    
}
