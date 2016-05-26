//
//  AdmSearchViewController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/13.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import FMDB
import Toast

class AdmSearchViewController: UIViewController {
    
    var segment = UISegmentedControl()
    let allCell = "AllTableViewCell"
    let nowCell = "NowTableViewCell"
    let passCell = "DidPassTableViewCell"
    let notPassCell = "DidNotPassTableViewCell"
    let tableView = UITableView(frame: CGRect())
    var selectIndex = 0
    var date = ""
    
    var index = 0
    var allLeave : [DisLeaveInfo] = []
    var nowLeave : [DisLeaveInfo] = []
    var didPass : [DisLeaveInfo] = []
    var didNotPass : [DisLeaveInfo] = []
    let leave = LeaveInfoM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leave.delegate = self
        self.view.backgroundColor = LHBackGroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "查询"
        let dataFormart = NSDateFormatter()
        dataFormart.dateFormat = "yyyy-MM-dd"
        date = dataFormart.stringFromDate(NSDate())
        print("date = \(date)")
        initSegment()
        initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    func initSegment() {
        self.view.addSubview(segment)
        segment.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(64)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
        })
        segment.insertSegmentWithTitle("全部", atIndex: 0, animated: true)
        segment.insertSegmentWithTitle("当前请假", atIndex: 1, animated: true)
        segment.insertSegmentWithTitle("历史通过", atIndex: 2, animated: true)
        segment.insertSegmentWithTitle("历史未通过", atIndex: 3, animated: true)
        segment.selectedSegmentIndex = 0
        indexZero()
        segment.addTarget(self, action: "segmentAction:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func initTableView() {
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(100)
            make.bottom.equalTo(-49)
            make.left.equalTo(0)
            make.right.equalTo(0)
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = LHBackGroundColor()
        tableView.tableFooterView = UIView()
        var cellNib = UINib(nibName: "AllTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: allCell)
        cellNib = UINib(nibName: "NowTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: nowCell)
        cellNib = UINib(nibName: "DidPassTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: passCell)
        cellNib = UINib(nibName: "DidNotPassTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: notPassCell)
        startHeadRefresh(tableView, reloadData: getData)
    }
    
    func getData() {
        switch index {
        case 0:
            indexZero()
        case 1:
            indexOne()
        case 2:
            indexTwo()
        case 3:
            indexThree()
        default:
            break
        }
    }
    
    func segmentAction(seg :UISegmentedControl) {
        index = seg.selectedSegmentIndex
        switch index {
        case 0:
            allLeave.removeAll()
            indexZero()
        case 1:
            nowLeave.removeAll()
            indexOne()
        case 2:
            didPass.removeAll()
            indexTwo()
        case 3:
            didNotPass.removeAll()
            indexThree()
        default:
            break
        }
    }
}

extension AdmSearchViewController : LeaveInfoMe {
    
    func success(userInfo: [LeaveInfoItem]) {
        
        switch index {
        case 0:
            userInfo.forEach({
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
                self.allLeave.append(dis)
            })
        case 1:
            userInfo.forEach({
                if $0.endTime > self.date && $0.type == "1" {
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
                    self.nowLeave.append(dis)
                }
            })
        case 2:
            userInfo.forEach({
                if $0.type == "1" && $0.startTime < date {
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
                    self.didPass.append(dis)
                }
            })
        case 3:
            userInfo.forEach({
                if $0.type == "1" && $0.startTime < date {
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
                    self.didNotPass.append(dis)
                }
            })
        default:
            return
        }
        popHud()
        stopHeadRefresh(tableView)
        tableView.reloadData()
    }
    
    func error() {
        popHud()
        ToastInfo("网络错误")
    }
    
}


extension AdmSearchViewController {
    
    func indexZero() {
        selectIndex = 0
        getUserLeaveInfo()
    }
    
    func indexOne() {
        selectIndex = 1
        getNowLeave()
    }
    
    func indexTwo() {
        selectIndex = 2
        getHistoryPass()
    }
    
    func indexThree() {
        selectIndex = 3
        getHistoryNotPass()
    }
    
    func getUserLeaveInfo() {
        allLeave.removeAll()
        leave.getData()
    }
    
    func getNowLeave() {
        nowLeave.removeAll()
        leave.getData()
    }
    
    func getHistoryPass() {
        didPass.removeAll()
        leave.getData()
    }
    
    func getHistoryNotPass() {
        didNotPass.removeAll()
        leave.getData()
    }
    
}

extension  AdmSearchViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var resultCell = UITableViewCell()
        switch selectIndex {
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(allCell, forIndexPath: indexPath) as! AllTableViewCell
            if indexPath.row == 0 {
                cell.Name.text = "姓名"
                cell.Name.font = LHFont(18)
                cell.Name.textColor = UIColor.blueColor()
                cell.Name.textAlignment = NSTextAlignment.Center
                cell.startTime.text = "起始时间"
                cell.startTime.font = LHFont(18)
                cell.startTime.textColor = UIColor.blueColor()
                cell.startTime.textAlignment = NSTextAlignment.Center
                cell.endTime.text = "终止时间"
                cell.endTime.font = LHFont(18)
                cell.endTime.textColor = UIColor.blueColor()
                cell.endTime.textAlignment = NSTextAlignment.Center
                cell.reson.text = "原因"
                cell.reson.font = LHFont(18)
                cell.reson.textColor = UIColor.blueColor()
                cell.reson.textAlignment = NSTextAlignment.Center
                cell.status.text = "天数"
                cell.status.font = LHFont(18)
                cell.status.textColor = UIColor.blueColor()
                cell.status.textAlignment = NSTextAlignment.Center
            } else {
                cell.Name.text = didPass[indexPath.row - 1].name
                cell.startTime.text = didPass[indexPath.row - 1].startTime
                cell.endTime.text = didPass[indexPath.row - 1].endTime
                cell.reson.text = didPass[indexPath.row - 1].reson
//                guard let numberDays = userLeave[indexPath.row - 1]["numberDays"] else {
//                    return UITableViewCell()
//                }
//                
//                if numberDays.hasPrefix("-") {
//                    cell.status.text = "0"
//                } else {
                    cell.status.text = "\(didPass[indexPath.row - 1].numberDays)"
//                }
                
                cell.Name.font = LHFont(14)
                cell.startTime.font = LHFont(14)
                cell.endTime.font = LHFont(14)
                cell.reson.font = LHFont(14)
                cell.status.font = LHFont(14)
            }
            
            resultCell = cell
            print("\(selectIndex)")
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(nowCell, forIndexPath: indexPath) as! NowTableViewCell
            if indexPath.row == 0 {
                cell.Name.text = "姓名"
                cell.Name.font = LHFont(18)
                cell.Name.textColor = UIColor.blueColor()
                cell.Name.textAlignment = NSTextAlignment.Center
                cell.startTime.text = "起始时间"
                cell.startTime.font = LHFont(18)
                cell.startTime.textColor = UIColor.blueColor()
                cell.startTime.textAlignment = NSTextAlignment.Center
                cell.endTime.text = "终止时间"
                cell.endTime.font = LHFont(18)
                cell.endTime.textColor = UIColor.blueColor()
                cell.endTime.textAlignment = NSTextAlignment.Center
                cell.reson.text = "原因"
                cell.reson.font = LHFont(18)
                cell.reson.textColor = UIColor.blueColor()
                cell.reson.textAlignment = NSTextAlignment.Center
                cell.status.text = "天数"
                cell.status.font = LHFont(18)
                cell.status.textColor = UIColor.blueColor()
                cell.status.textAlignment = NSTextAlignment.Center
            } else {
                cell.Name.text = allLeave[indexPath.row - 1].name
                cell.startTime.text = allLeave[indexPath.row - 1].startTime
                cell.endTime.text = allLeave[indexPath.row - 1].endTime
                cell.reson.text = allLeave[indexPath.row - 1].reson
                cell.status.text = "\(allLeave[indexPath.row - 1].numberDays)"
            }
            resultCell = cell
            print("\(selectIndex)")
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(passCell, forIndexPath: indexPath) as! DidPassTableViewCell
            if indexPath.row == 0 {
                cell.Name.text = "姓名"
                cell.Name.font = LHFont(18)
                cell.Name.textColor = UIColor.blueColor()
                cell.Name.textAlignment = NSTextAlignment.Center
                cell.startTime.text = "起始时间"
                cell.startTime.font = LHFont(18)
                cell.startTime.textColor = UIColor.blueColor()
                cell.startTime.textAlignment = NSTextAlignment.Center
                cell.endTime.text = "终止时间"
                cell.endTime.font = LHFont(18)
                cell.endTime.textColor = UIColor.blueColor()
                cell.endTime.textAlignment = NSTextAlignment.Center
                cell.reson.text = "原因"
                cell.reson.font = LHFont(18)
                cell.reson.textColor = UIColor.blueColor()
                cell.reson.textAlignment = NSTextAlignment.Center
                cell.status.text = "天数"
                cell.status.font = LHFont(18)
                cell.status.textColor = UIColor.blueColor()
                cell.status.textAlignment = NSTextAlignment.Center
            } else {
                cell.Name.text = nowLeave[indexPath.row - 1].name
                cell.startTime.text = nowLeave[indexPath.row - 1].startTime
                cell.endTime.text = nowLeave[indexPath.row - 1].endTime
                cell.reson.text = nowLeave[indexPath.row - 1].reson
                cell.status.text = "\(nowLeave[indexPath.row - 1].numberDays)"
            }
            resultCell = cell
            print("\(selectIndex)")
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(notPassCell, forIndexPath: indexPath) as! DidNotPassTableViewCell
            if indexPath.row == 0 {
                cell.Name.text = "姓名"
                cell.Name.font = LHFont(18)
                cell.Name.textColor = UIColor.blueColor()
                cell.Name.textAlignment = NSTextAlignment.Center
                cell.startTime.text = "起始时间"
                cell.startTime.font = LHFont(18)
                cell.startTime.textColor = UIColor.blueColor()
                cell.startTime.textAlignment = NSTextAlignment.Center
                cell.endTime.text = "终止时间"
                cell.endTime.font = LHFont(18)
                cell.endTime.textColor = UIColor.blueColor()
                cell.endTime.textAlignment = NSTextAlignment.Center
                cell.reson.text = "原因"
                cell.reson.font = LHFont(18)
                cell.reson.textColor = UIColor.blueColor()
                cell.reson.textAlignment = NSTextAlignment.Center
                cell.status.text = "天数"
                cell.status.font = LHFont(18)
                cell.status.textColor = UIColor.blueColor()
                cell.status.textAlignment = NSTextAlignment.Center
            } else {
                cell.Name.text = didNotPass[indexPath.row - 1].name
                cell.startTime.text = didNotPass[indexPath.row - 1].startTime
                cell.endTime.text = didNotPass[indexPath.row - 1].endTime
                cell.reson.text = didNotPass[indexPath.row - 1].reson
                cell.status.text = "\(didNotPass[indexPath.row - 1].numberDays)"
            }
            resultCell = cell
            print("\(selectIndex)")
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(allCell, forIndexPath: indexPath) as! AllTableViewCell
            resultCell = cell
        }
        return resultCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectIndex {
        case 0:
            return allLeave.count + 1
        case 1:
            return nowLeave.count + 1
        case 2:
            return didPass.count + 1
        case 3:
            return didNotPass.count + 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            return
        }
        self.hidesBottomBarWhenPushed = true
        let userVC = SearchResonInfoViewController()
        if selectIndex == 0 {
            userVC.userLeave = allLeave[indexPath.row - 1]
        } else if selectIndex == 1 {
            userVC.userLeave = nowLeave[indexPath.row - 1]
        } else if selectIndex == 2 {
            userVC.userLeave = didPass[indexPath.row - 1]
        } else if selectIndex == 3 {
            userVC.userLeave = didNotPass[indexPath.row - 1]
        }
        userVC.userLeave = allLeave[indexPath.row - 1]
        self.navigationController?.pushViewController(userVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}


/*
 
 func getUserLeaveInfo() {
 let database = FMDatabase(path: path().path)
 userLeave.removeAll()
 if database.open() {
 do {
 let rs = try database.executeQuery( "select id, name, starttime, endtime, numberDays, type, typeInfo, photo, status,location from leavetable", values: nil)
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
 userLeave.forEach({
 print("\($0["starttime"])")
 })
 } catch {
 print("查询失败!")
 }
 } else {
 print("打开失败!")
 }
 print("userLeave = \(userLeave)")
 database.close()
 }
 
 func getNowLeave() {
 let database = FMDatabase(path: path().path)
 nowLeave.removeAll()
 if database.open() {
 do {
 let rs = try database.executeQuery( "select id, name, starttime, endtime, numberDays, type, typeInfo, photo, status,location from leavetable where \(date)<endtime", values: nil)
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
 if dic["status"] == "1" {
 nowLeave.append(dic)
 }
 }
 tableView.reloadData()
 nowLeave.forEach({
 print("\($0["starttime"])")
 })
 } catch {
 print("查询失败!")
 }
 } else {
 print("打开失败!")
 }
 print("nowLeave = \(nowLeave)")
 database.close()
 
 }
 
 func getHistoryPass() {
 let database = FMDatabase(path: path().path)
 historyPass.removeAll()
 if database.open() {
 do {
 let rs = try database.executeQuery( "select id, name, starttime, endtime, numberDays, type, typeInfo, photo, status, location from leavetable where starttime<? and status=?", values: [date,"1"])
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
 historyPass.append(dic)
 }
 tableView.reloadData()
 historyPass.forEach({
 print("\($0["starttime"])")
 })
 } catch {
 print("查询失败!")
 }
 } else {
 print("打开失败!")
 }
 print("historyPass = \(historyPass)")
 database.close()
 
 }
 
 func getHistoryNotPass() {
 let database = FMDatabase(path: path().path)
 historyNotPass.removeAll()
 if database.open() {
 do {
 let rs = try database.executeQuery( "select id, name, starttime, endtime, numberDays, type, typeInfo, photo, status ,location from leavetable where starttime<? and status=?", values: [date,"2"])
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
 historyNotPass.append(dic)
 }
 tableView.reloadData()
 historyNotPass.forEach({
 print("\($0["starttime"])")
 })
 } catch {
 print("查询失败!")
 }
 } else {
 print("打开失败!")
 }
 print("historyNotPass = \(historyNotPass)")
 database.close()
 }

 
 */


