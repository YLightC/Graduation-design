//
//  UserReadyShowViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/20.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class UserReadyShowViewController: UIViewController {

    let tableView = UITableView()
    let cellIdentifier = "UserReadyTableViewCell"
    var disActivity : [DisActivityInfo] = []
    let leve = ActivityInfoM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leve.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = LHBackGroundColor()
        initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(64)
            make.bottom.equalTo(-64)
            make.left.equalTo(0)
            make.right.equalTo(0)
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        let cellNib = UINib(nibName: "UserReadyTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: cellIdentifier)
        startHeadRefresh(tableView, reloadData: getData)
        //        initGetData()
        getData()
    }
    
    func getData() {
        showHud("正在加载...")
        leve.getData()
    }
    
}

extension UserReadyShowViewController : ActivityMe {
    
    func success(userInfo: [activityInfoItem]) {
        disActivity.removeAll()
        let dataFormat = NSDateFormatter()
        dataFormat.dateFormat = "yyyy-MM-dd"
        let starttime = dataFormat.stringFromDate(NSDate())
        
        userInfo.forEach({
            if $0.activityTime < starttime {
                var dis = DisActivityInfo()
                dis.activityAddress = $0.activityAddress
                dis.activityCover = $0.activityCover
                dis.activityName = $0.activityName
                dis.activityTime = $0.activityTime
                self.disActivity.append(dis)
            }
        })
        stopHeadRefresh(tableView)
        popHud()
        tableView.reloadData()
    }
    
    func error() {
        popHud()
        ToastInfo("网络出错")
    }
}

extension UserReadyShowViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 15
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 15))
            view.backgroundColor = UIColor.clearColor()
            return view
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return disActivity.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserReadyTableViewCell
        cell.nameLabel.text = disActivity[indexPath.section].activityName
        cell.timeLabel.text = disActivity[indexPath.section].activityTime
        cell.addressLabel.text = disActivity[indexPath.section].activityAddress
        //        cell.titleImage.image = getImage(willActivityInfo[indexPath.section]["accover"]!)
        cell.titleImage.image = UIImage(named: disActivity[indexPath.section].activityCover)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
}
