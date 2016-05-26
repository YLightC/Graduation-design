//
//  SqliteSql.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/16.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import Foundation
import MBProgressHUD
import Toast

extension UIViewController {
    func showHud(text:String? = nil) {
        for subView in self.view.subviews {
            if let _ = subView as? MBProgressHUD {
                return
            }
        }
        let hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = text
    }
    
    func popHud() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func ToastInfo(info :String) {
        let style = CSToastStyle(defaultStyle: ())
        style.messageColor = UIColor.orangeColor()
        self.view.makeToast(info, duration: 1, position: CSToastPositionCenter, style: style)
    }
}

//sqlite 数据库路径
func dataFilePath(imagePath :String) -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, false) as [NSString]
    let path = paths[0].stringByAppendingPathComponent(imagePath)
    return path
}

func daysBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
    let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: d1, toDate: d2, options: [])
    return dc.day
}

//存图片
func saveImage(image :UIImage, fileName :String) -> Bool {
    
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [NSString]
    let filePath = paths[0].stringByAppendingPathComponent(fileName)
    let data = NSData(data: UIImageJPEGRepresentation(image, 0.2)!)
    let result = data.writeToFile(filePath, atomically: true)
    
    return result
    
}
//取图片
func getImage(fileName :String) -> UIImage? {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [NSString]
    let filePath = paths[0].stringByAppendingPathComponent(fileName)
    do {
        let data = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMapped)
        let image = UIImage(data: data)
        return image
    } catch {
        return nil
    }
}



func getImageData(fileName :String) -> NSData? {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [NSString]
    let filePath = paths[0].stringByAppendingPathComponent(fileName)
    do {
        let data = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMapped)
        return data
    } catch {
        return nil
    }
}
