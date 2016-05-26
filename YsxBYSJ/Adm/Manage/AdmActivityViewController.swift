//
//  AdmActivityViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/13.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class AdmActivityViewController: SegmentedViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = WillCheckViewController()
        vc1.segmentTitle = "已审核"
        let vc2 = DidCheckViewController()
        vc2.segmentTitle = "未审核"
        let vc3 = AddDeleteUserViewController()
        vc3.segmentTitle = "增删员工"
        let vc4 = AddDelActivityViewController()
        vc4.segmentTitle = "活动管理"
        myViewControllers = [vc1,vc2,vc3,vc4]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
