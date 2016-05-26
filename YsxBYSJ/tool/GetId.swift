//
//  GetId.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/16.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import SDWebImage

protocol GetIdDelegate {
    func sendId(inout userId :String)
}


class GetId : NSObject {
    
    static var id = ""
    var delegate : GetIdDelegate!
    
    func UserId() {
        print("GetId init()")
        delegate.sendId(&GetId.id)
    }
    
}

extension UIImageView {
    func lh_setImageWithURL(url:String,placeholderImage:UIImage?) {
        let imageUrlString = "http://\(UserLonInInfo.sharedInstance.ip):8080/ColorsTripServ/" + url + ".jpeg"
        let imageUrl = NSURL(string: imageUrlString)
        self.sd_setImageWithURL(imageUrl, placeholderImage: placeholderImage ?? UIImage())
     }
}