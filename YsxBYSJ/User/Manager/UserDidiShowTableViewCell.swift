//
//  UserDidiShowTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/20.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class UserDidiShowTableViewCell: UITableViewCell {

    @IBOutlet var addressImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    let overLabel = UILabel(frame: CGRect())
    
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
        self.contentView.addSubview(overLabel)
        overLabel.font = LHFont(20)
        overLabel.textColor = UIColor.redColor()
        overLabel.text = "已结束"
        overLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_2_PI))
        overLabel.textAlignment = NSTextAlignment.Center
        overLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(50)
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.right.equalTo(-40)
        })
    }
    
}
