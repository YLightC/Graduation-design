//
//  Refresh.swift
//  BS
//
//  Created by 姚驷旭 on 16/3/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import Foundation
import MJRefresh

extension UIViewController {

    func startHeadRefresh(ScrollView :UIScrollView,reloadData: Void -> Void) {
        ScrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: reloadData)
    }
    
    func stopHeadRefresh(ScrollView :UIScrollView) {
        ScrollView.mj_header.endRefreshing()
    }

    
}