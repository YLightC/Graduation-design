//
//  UserViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/12.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import Toast

class UserViewController: UITabBarController {

    var userid = "" //用户id
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = GetId.id
        self.tabBar.opaque = true
        self.view.backgroundColor = UIColor.whiteColor()
        ToastInfo("登录成功!")
        popHud()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        let lineView = UIView()
        self.tabBar.addSubview(lineView)
        lineView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0.5)
        }
        lineView.backgroundColor = UIColor ( red: 0.3483, green: 0.3483, blue: 0.3483, alpha: 0.843380489864865 )
        
        var viewControllers = [UIViewController]()
        
        var  vc:UIViewController = ManagerViewController()
        var nav  = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "首页"), selectedImage:UIImage(named: "首页-选中"))
        nav.tabBarItem.tag = 0
        viewControllers.append(nav)
        
        vc = ActivityViewController(userid: self.userid)
        vc.tabBarItem = UITabBarItem(title: "管理", image: UIImage(named: "购票"), selectedImage:UIImage(named: "购票-选中"))
        nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.tag = 1
        viewControllers.append(nav)
        
        vc = SearchViewController(userid :self.userid)
        nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: "查询", image: UIImage(named: "发现"), selectedImage:UIImage(named: "发现-选中"))
        nav.tabBarItem.tag = 2
        viewControllers.append(nav)
        
        vc = UserMineViewController(userid: self.userid)
        nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "我的"), selectedImage:UIImage(named: "我的-选中"))
        nav.tabBarItem.tag = 3
        viewControllers.append(nav)
        
        self.viewControllers = viewControllers
    }

    
}
