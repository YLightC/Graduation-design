//
//  WillCheckViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/2/2.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Toast

//已审核
class WillCheckViewController: UIViewController {
    
    let tableView = UITableView()
    let cellIdentifier = "DidCheck"
    var userLeave : [DisLeaveInfo] = []
    let leave = LeaveInfoM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leave.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = LHBackGroundColor()
        initTableView()
        //        getUserLeaveInfo()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-49)
        })
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let cellNib = UINib(nibName: "WillCheckTableViewCell" , bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: cellIdentifier)
        startHeadRefresh(tableView, reloadData: getData)
        getData()
    }
    
    func getData() {
        showHud("正在加载...")
        leave.getData()
    }
    
}


extension WillCheckViewController : LeaveInfoMe {
    
    func success(userInfo: [LeaveInfoItem]) {
       userLeave.removeAll()
        userInfo.forEach({
            if $0.type != "0" {
                var dis = DisLeaveInfo()
                dis.endTime = $0.endTime
                dis.id = $0.id
                dis.location = $0.location
                dis.name = $0.name
                dis.numberDays = $0.numberDays
                dis.proofMaterial = $0.proofMaterial
                dis.reson = $0.reson
                dis.startTime = $0.startTime
                dis.type = $0.type
                dis.leaveMessage = $0.leaveMessage
                userLeave.append(dis)
            }
        })
        popHud()
        stopHeadRefresh(tableView)
        tableView.reloadData()
    }
    
    func error() {
        popHud()
        ToastInfo("网络出错")
    }
    
}


extension WillCheckViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLeave.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WillCheckTableViewCell
        if indexPath.row == 0 {
            cell.Name.font = LHFont(15)
            cell.Name.textAlignment = NSTextAlignment.Center
            cell.Name.text = "姓名"
            cell.Type.font = LHFont(15)
            cell.Type.textAlignment = NSTextAlignment.Center
            cell.Type.text = "类型"
            cell.StartTime.font = LHFont(15)
            cell.StartTime.textAlignment = NSTextAlignment.Center
            cell.StartTime.text = "起始时间"
            cell.EndTime.font = LHFont(15)
            cell.EndTime.textAlignment = NSTextAlignment.Center
            cell.EndTime.text = "终止时间"
            cell.Status.font = LHFont(15)
            cell.Status.textAlignment = NSTextAlignment.Center
            cell.Status.text = "审核状态"
            cell.Status.textColor = UIColor.redColor()
        } else {
            print("indexPath.row == \(indexPath.row)")
            cell.Name.font = LHFont(13)
            cell.Name.text = userLeave[indexPath.row - 1].name
            cell.Name.textAlignment = NSTextAlignment.Right
            cell.Type.font = LHFont(13)
            cell.Type.text = userLeave[indexPath.row - 1].reson
            cell.Type.textAlignment = NSTextAlignment.Right
            cell.StartTime.font = LHFont(13)
            cell.StartTime.text = userLeave[indexPath.row - 1].startTime
            cell.StartTime.textAlignment = NSTextAlignment.Right
            cell.EndTime.font = LHFont(13)
            cell.EndTime.text = userLeave[indexPath.row - 1].endTime
            cell.EndTime.textAlignment = NSTextAlignment.Right
            
            if userLeave[indexPath.row - 1].type == "1" {
                cell.Status.text = "通过"
            } else {
                cell.Status.text = "未通过"
            }
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            return
        }
        self.parentViewController?.hidesBottomBarWhenPushed = true
        let userVC = SearchResonInfoViewController()
        userVC.userLeave = userLeave[indexPath.row - 1]
        self.navigationController?.pushViewController(userVC, animated: true)
        self.parentViewController?.hidesBottomBarWhenPushed = false
    }
}


/*
 
 func scrollViewDidScroll(scrollView: UIScrollView) {
 getUserLeaveInfo()
 }
 
 func getUserLeaveInfo() {
 let database = FMDatabase(path: path().path)
 userLeave.removeAll()
 if database.open() {
 do {
 let rs = try database.executeQuery( "select id, name, starttime, endtime, numberDays, type, typeInfo, photo, status, location from leavetable where status<>'0' order by starttime desc", values: nil)
 while rs.next() {
 let id = rs.stringForColumn("id")
 let name = rs.stringForColumn("name")
 let starttime = rs.stringForColumn("starttime")
 let endtime = rs.stringForColumn("endtime")
 let numberDays = rs.stringForColumn("numberDays")
 let type = rs.stringForColumn("type")
 let typeInfo = rs.stringForColumn("typeInfo")
 let photo = rs.stringForColumn("photo")
 let status = rs.stringForColumn("status")
 let location = rs.stringForColumn("location")
 var dic = Dictionary<String,String>()
 dic["id"] = id
 dic["name"] = name
 dic["starttime"] = starttime
 dic["endtime"] = endtime
 dic["numberDays"] = numberDays
 dic["type"] = type
 dic["typeInfo"] = typeInfo
 dic["photo"] = photo
 dic["status"] = status
 dic["location"] = location
 userLeave.append(dic)
 }
 tableView.reloadData()
 print("userLeave = \(userLeave)")
 } catch {
 print("查询失败!")
 }
 } else {
 print("打开失败!")
 }
 print("userLeave = \(userLeave)")
 database.close()
 }
 */

