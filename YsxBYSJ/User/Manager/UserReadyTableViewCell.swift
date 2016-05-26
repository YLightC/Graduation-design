//
//  UserReadyTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/20.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class UserReadyTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func initCell() {
        titleImage.clipsToBounds = true
        titleImage.contentMode = .ScaleAspectFill
        titleImage.image = UIImage(named: "activity")
        timeLabel.font = LHFont(11)
        timeLabel.textColor = LHTextColor()
        addressLabel.font = LHFont(11)
        addressLabel.textColor = LHTextColor()
    }
    
}
