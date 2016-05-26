//
//  AddDeleteTableViewCell.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/16.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class AddDeleteTableViewCell: UITableViewCell {

    @IBOutlet var type: UILabel!
    @IBOutlet var InfoTextFiled: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        type.textAlignment = .Right
        InfoTextFiled.text = nil
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .None
        // Configure the view for the selected state
    }
    
}
