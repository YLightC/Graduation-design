//
//  SetViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/17.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit

class AdmSetViewController: UIViewController {
    
    let tableView = UITableView()
    let cellIdentifier = "AdmSetTableViewCell"
    var userid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LHBackGroundColor()
        self.navigationItem.title = "设置"
        self.view.backgroundColor = LHBackGroundColor()
        // Do any additional setup after loading the view.
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
    
    func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        let cellNib = UINib(nibName: "AdmSetTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: cellIdentifier)
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 40))
        headView.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView()
    }
}

extension AdmSetViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AdmSetTableViewCell
        
        if indexPath.row == 0 {
            cell.info.text = "修改密码"
        } else {
            cell.info.text = "退出登录"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.hidesBottomBarWhenPushed = true
            let setNewVC = SetNewPwdViewController()
            setNewVC.userid = self.userid
            self.navigationController?.pushViewController(setNewVC, animated: true)
        } else if indexPath.row == 1 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
