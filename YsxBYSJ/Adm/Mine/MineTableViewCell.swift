//
//  MineTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {
    @IBOutlet var headImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var id: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Configure the view for the selected state
    }
    
    func initCell() {
        headImage.layer.cornerRadius = 2
        headImage.layer.masksToBounds = true
        headImage.image = UIImage(named: "find_musician")
        
        name.font = LHFont(15)
        name.textColor = theTheme().textColor
        name.text = "姚驷旭"
        
        id.font = LHFont(15)
        id.textColor = theTheme().textColor
        id.text = "2012020186"
    }
}
