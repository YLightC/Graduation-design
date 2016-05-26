//
//  Theme.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}

func currentTheme() -> Theme {
    return ThemeManager.currentTheme()
}

enum Theme: Int {
    case Dark
    
    var tintColor: UIColor {
        switch self {
        case .Dark:
            return UIColor.blackColor()
        }
    }
    
    var secondarColor:UIColor {
        //        return UIColor(red:0.95, green:0.18, blue:0.47, alpha:1)
        return UIColorFromHex(0xf32c77)
    }
    
    var darkTextColor:UIColor {
        return UIColor(red:0.27, green:0.28, blue:0.28, alpha:1)
    }
    var textColor:UIColor {
        return UIColor(red:0.51, green:0.51, blue:0.51, alpha:1)
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .Dark:
            return .Black
        }
    }
    
    var lineGrayColor: UIColor {
        return UIColor(red:0.85, green:0.85, blue:0.85, alpha:1)
    }
    
    var darkLineColor : UIColor {
        return UIColor(red:0.5, green:0.5, blue:0.5, alpha:1)
    }
    
    //    var navigationBackgroundImage: UIImage? {
    //        return self == .Graphical ? UIImage(named: "navBackground") : nil
    //    }
    //
    //    var tabBarBackgroundImage: UIImage? {
    //        return self == .Graphical ? UIImage(named: "tabBarBackground") : nil
    //    }
    
    var backgroundColor: UIColor {
        switch self {
        case .Dark:
            return UIColorFromHex(0xf5f5f5)
        }
    }
    
    var contentColor:UIColor {
        return UIColor.whiteColor()
    }
    
    var mainFont:UIFont {
        return fontWithSizeInPixels(20)
    }
    
    
    var fontName:String {
        return "Helvetica"
    }
    
    var boldFontName:String {
        return "Helvetica-Bold"
    }
    
    
    func boldFontWithSizeInPixels(pixels:CGFloat) -> UIFont {
        return UIFont(name:boldFontName, size: pixels)!
    }
    
    
    func fontWithSizeInPixels(pixels:CGFloat) -> UIFont {
        return UIFont(name:fontName, size: pixels)!
    }
    
}

let SelectedThemeKey = "SelectedTheme"

struct ThemeManager {
    static func currentTheme() -> Theme {
        if let storedTheme = NSUserDefaults.standardUserDefaults().valueForKey(SelectedThemeKey)?.integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .Dark
        }
    }
    
    static func applyTheme(theme: Theme) {
        NSUserDefaults.standardUserDefaults().setValue(theme.rawValue, forKey: SelectedThemeKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let sharedApplication = UIApplication.sharedApplication()
        sharedApplication.delegate?.window??.tintColor = theme.tintColor
        
        //        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().barTintColor = theme.backgroundColor
        //    UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, forBarMetrics: .Default)
        //    UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        //    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().barTintColor = theme.backgroundColor
        //    UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
        
        //    let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.imageWithRenderingMode(.AlwaysTemplate)
        //    let tabResizableIndicator = tabIndicator?.resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        //    UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
        
        //    let controlBackground = UIImage(named: "controlBackground")?
        //      .imageWithRenderingMode(.AlwaysTemplate)
        //      .resizableImageWithCapInsets(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        //    let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
        //      .imageWithRenderingMode(.AlwaysTemplate)
        //      .resizableImageWithCapInsets(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        
        //    UISegmentedControl.appearance().setBackgroundImage(controlBackground, forState: .Normal, barMetrics: .Default)
        //    UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, forState: .Selected, barMetrics: .Defaultrecruit)
        
        //    UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Normal)
        //    UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Disabled)
        //    UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Highlighted)
        //    UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), forState: .Normal)
        //    UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), forState: .Normal)
        
        //    UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), forState: .Normal)
        //    UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
        //      .resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), forState: .Normal)
        //    UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
        //      .imageWithRenderingMode(.AlwaysTemplate)
        //      .resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), forState: .Normal)
        
        UISegmentedControl.appearance().tintColor = theme.tintColor
        //        UISegmentedControl.appearance().setTitleTextAttributes([NSFontAttributeName:theme.font(19.0)], forState: .Normal)
        
        
        UISwitch.appearance().onTintColor = theme.tintColor.colorWithAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.tintColor
        
    }
}

func theTheme() -> Theme {
    return ThemeManager.currentTheme()
}

func backgroudColor() -> UIColor {
    return theTheme().backgroundColor
}

func LHDartTextColor() -> UIColor {
    return theTheme().darkTextColor
}

func LHTextColor() -> UIColor {
    return theTheme().textColor
}

func LHLineColor() -> UIColor {
    return theTheme().lineGrayColor
}

func LHDarkLineColor() -> UIColor {
    return theTheme().darkLineColor
}

func LHFont(size:CGFloat) -> UIFont {
    return theTheme().fontWithSizeInPixels(size)
}

func LHBoldFont(size:CGFloat) -> UIFont {
    return theTheme().boldFontWithSizeInPixels(size)
}

func LHTintColor() -> UIColor {
    return theTheme().tintColor
}

func LHBackGroundColor() -> UIColor {
    return theTheme().backgroundColor
}

func LHSecondarColor() -> UIColor {
    return theTheme().secondarColor
}

func messageBoxButtonColor() -> UIColor {
    return  UIColor(red:0.95, green:0.18, blue:0.47, alpha:1)
}



