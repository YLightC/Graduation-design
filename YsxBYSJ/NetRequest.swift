//
//  NetRequest.swift
//  YsxBYSJ
//
//  Created by 姚驷旭 on 16/5/18.
//  Copyright © 2016年 ysx. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

public enum  SensitiveWords {
    case LogIn
    case UserInfo
    case LeavelInfo
    case ActivityInfo
    case ChangePwd(id: String,pwd: String)
    case AddUser(id: String,pwd: String,isAdm: String,headphoto: String,name: String,sex: String,address:String,phoneNumber: String)
    case DeleteUser(id: String)
    case ChangeStatus(id: String,starttime: String, endtime: String,type: String)
    case ChangeUserHeadPhoto(id:String,headPhoto: String)
    case AddActivity(activityName: String,activityTime: String,activityAddress: String,activityCover: String)
    case AddUserLeaveInfo(id: String,name: String,starttime: String,endtime: String,numberDays: Int,type: String,reson:String,proofMaterial: String,location: String,leaveMessage: String)
}

extension SensitiveWords :TargetType {
        public var baseURL: NSURL { return NSURL(string: "http://\(UserLonInInfo.sharedInstance.ip):8080/ColorsTripServ/servlet")! }
//    public var baseURL: NSURL { return NSURL(string: LHBaseUrl)! }
    public var path: String {
        switch self {
        case .LogIn:
            return "/GetUserTable"
        case .UserInfo:
            return "/GetUserInfo"
        case .LeavelInfo:
            return "/GetLeaveInfo"
        case .ActivityInfo:
            return "/GetActivityInfo"
        case .ChangePwd:
            return "/ChangeUserPwd"
        case .AddUser:
            return "/GetAddUser"
        case .DeleteUser:
            return "/GetDeleteUser"
        case .ChangeStatus:
            return "/GetChangeStatus"
        case .ChangeUserHeadPhoto:
            return "/GetChangeUserHeadPhoto"
        case .AddActivity:
            return "/GetAddActivity"
        case .AddUserLeaveInfo:
            return "/GetUserLeaveInfo"
        }
    }
    public var parameters: [String: AnyObject]? {
        switch self {
        case .LogIn:
            return [:]
        case .UserInfo:
            return [:]
        case .LeavelInfo:
            return [:]
        case .ActivityInfo:
            return [:]
        case let .ChangePwd(id,pwd) :
            return ["userId":id,"pwd":pwd]
        case let .AddUser(id,pwd,isAdm,headphoto,name,sex,address,phoneNumber):
            return ["id": id,"pwd": pwd, "isAdm": isAdm,"headphoto": headphoto,"name":name,"sex":sex,"address":address,"phoneNumber":phoneNumber]
        case let .DeleteUser(id):
            return ["id":id]
        case let .ChangeStatus(id,starttime,endtime,type):
            return ["id":id,"starttime":starttime,"endtime":endtime,"type":type]
        case let .ChangeUserHeadPhoto(id,headphoto):
            return ["id":id,"headphoto":headphoto]
        case let .AddActivity(activityName,activityTime,activityAddress,activityCover):
            return ["activityName":activityName,"activityTime":activityTime,"activityAddress":activityAddress,"activityCover":activityCover]
        case let .AddUserLeaveInfo(id,name,starttime,endtime,numberDays,type,reson,proofMaterial,location,leaveMessage):
            return ["id":id,"name":name,"starttime":starttime,"endtime":endtime,"numberDays":numberDays,"type":type,"reson":reson,"proofMaterial":proofMaterial,"location":location,"leaveMessage":leaveMessage]
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var sampleData: NSData {
        return "SensitiveWords".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

let SensitiveWordsProvider = MoyaProvider<SensitiveWords>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])


//登录
protocol LogMe {
    func success(userInfo: [LogMessage])
    func error()
}
class GetSensitiveWords {
    
//    class var sharedInstance : GetSensitiveWords{
//        struct Static{
//            static let instance:GetSensitiveWords = GetSensitiveWords()
//        }
//        return Static.instance
//    }

    var delegate : LogMe!
    
    func getData() {
        SensitiveWordsProvider.request(SensitiveWords.LogIn) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<SystemMessageResponseData>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.success(data.list)
                        print("dai li mei zhi xing")
                    } else {
                    
                    }
                } catch {
                    self.delegate.error()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}

//userInfo
protocol UserInfoMe {
    func success(userInfo: [UserMessageItem])
    func error()
}
class UserInfo {
    
    class var sharedInstance : UserInfo{
        struct Static{
            static let instance:UserInfo = UserInfo()
        }
        return Static.instance
    }
    
    var delegate : UserInfoMe!
    
    func getData() {
        SensitiveWordsProvider.request(SensitiveWords.UserInfo) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<UserMessage>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.success(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.error()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}


//leaveInfo
protocol LeaveInfoMe {
    func success(userInfo: [LeaveInfoItem])
    func error()
}
class LeaveInfoM {
    
//    class var sharedInstance : LeaveInfoM{
//        struct Static{
//            static let instance:LeaveInfoM = LeaveInfoM()
//        }
//        return Static.instance
//    }
    
    var delegate : LeaveInfoMe!
    
    func getData() {
        SensitiveWordsProvider.request(SensitiveWords.LeavelInfo) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<LeaveInfo>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.success(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.error()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
    
}

//activityInfo
protocol ActivityMe {
    func success(userInfo: [activityInfoItem])
    func error()
}
class ActivityInfoM {
    
//    class var sharedInstance : ActivityInfoM{
//        struct Static{
//            static let instance:ActivityInfoM = ActivityInfoM()
//        }
//        return Static.instance
//    }
    
    var delegate : ActivityMe!
    
    func getData() {
        SensitiveWordsProvider.request(SensitiveWords.ActivityInfo) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<activityInfo>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.success(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.error()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}

//changPwd

protocol ChangePwdMe {
    func success(userInfo: [Int])
    func error()
}
class ChangeM {
    
    //    class var sharedInstance : LeaveInfoM{
    //        struct Static{
    //            static let instance:LeaveInfoM = LeaveInfoM()
    //        }
    //        return Static.instance
    //    }
    
    var delegate : ChangePwdMe!
    
    func getData(userId: String,pwd: String) {
        
        let changPwd = SensitiveWords.ChangePwd(id: userId, pwd: pwd)
        
        SensitiveWordsProvider.request(changPwd) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<ChangePwdModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.success(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.error()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}


//add User
protocol AddUserMe {
    func success(userInfo: [Int])
    func error()
}
class AddUserM {
    var delegate : AddUserMe!
    
    func getData(id: String,pwd: String, isAdm: String,headphoto: String,name:String,sex:String,address:String,phoneNumber: String) {
        
        let addUser = SensitiveWords.AddUser(id: id, pwd: pwd, isAdm: isAdm, headphoto: headphoto, name: name, sex: sex, address: address, phoneNumber: phoneNumber)
        
        SensitiveWordsProvider.request(addUser) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<AddUserModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.success(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.error()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}

//delete user
protocol DeleteUserMe {
    func dsuccess(userInfo: [Int])
    func derror()
}
class deleteUserM {
    var delegate : DeleteUserMe!
    
    func getData(id: String) {
        
        let deleteUser = SensitiveWords.DeleteUser(id: id)
        
        SensitiveWordsProvider.request(deleteUser) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<DeleteUserModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.dsuccess(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.derror()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}

//change status

protocol ChangeStatusMe {
    func csuccess(userInfo: [Int])
    func cerror()
}
class ChnangeStatusrM {
    var delegate : ChangeStatusMe!
    
    func getData(id: String,starttime: String,endtime:String,type: String) {
        
        let deleteUser = SensitiveWords.ChangeStatus(id: id, starttime: starttime, endtime: endtime, type: type)
        
        SensitiveWordsProvider.request(deleteUser) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<ChangeStatusModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.csuccess(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.cerror()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}

//changeUserHeadPhoto
protocol ChangeUserHeadphotoMe {
    func csuccess(userInfo: [Int])
    func cerror()
}
class ChangeUserHeadphotoM {
    var delegate : ChangeUserHeadphotoMe!
    
    func getData(id: String,headphoto: String) {
        
        let userHeadphoto = SensitiveWords.ChangeUserHeadPhoto(id: id, headPhoto: headphoto)
        
        SensitiveWordsProvider.request(userHeadphoto) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<ChangeUserHeadphotoModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.csuccess(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.cerror()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}


//Add Activity
protocol AddActivityMe {
    func csuccess(userInfo: [Int])
    func cerror()
}
class AddActivityM {
    var delegate : AddActivityMe!
    
    func getData(activityName: String,activityTime: String,activityAddress: String,activityCover: String) {
        
        let addActivity = SensitiveWords.AddActivity(activityName: activityName, activityTime: activityTime, activityAddress: activityAddress, activityCover: activityCover)
        
        SensitiveWordsProvider.request(addActivity) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<AddActivityModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.csuccess(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.cerror()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}

/*
 (id: String,name: String,starttime: String,endtime: String,numberDays: Int,type: String,reson:String,proofMaterial: String,location: String,leaveMessage: String)
 */


//AddUserLeaveInfo
protocol UserLeaveInfoMe {
    func csuccess(userInfo: [Int])
    func cerror()
}
class UserLeaveInfoM {
    var delegate : UserLeaveInfoMe!
    
    func getData(id: String,name: String,starttime: String,endtime: String,numberDays: Int,type: String,reson:String,proofMaterial: String,location: String,leaveMessage: String)
{
        
        let addUserLeaveInfo = SensitiveWords.AddUserLeaveInfo(id: id, name: name, starttime: starttime, endtime: endtime, numberDays: numberDays, type: type, reson: reson, proofMaterial: proofMaterial, location: location, leaveMessage: leaveMessage)
    
        SensitiveWordsProvider.request(addUserLeaveInfo) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    let JSON = try response.mapString()
                    if let data = Mapper<AddUserLeaveInfoModel>().map(JSON) {
                        print("data = \(data)")
                        self.delegate.csuccess(data.list)
                        print("dai li mei zhi xing")
                    } else {
                        
                    }
                } catch {
                    self.delegate.cerror()
                }
            case let .Failure(error):
                print("data = \(error)")
            }
        }
    }
}



