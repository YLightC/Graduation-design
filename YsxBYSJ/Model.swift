//
//  Model.swift
//  YsxBYSJ
//
//  Created by 姚驷旭 on 16/5/18.
//  Copyright © 2016年 ysx. All rights reserved.
//

import Foundation
import ObjectMapper


class UserLonInInfo {
    
    var id = ""
    var pwd = ""
    var isAdm = ""
    var headphoto = ""
    var name = ""
    var ip = ""
    
    class var sharedInstance : UserLonInInfo{
        struct Static{
            static let instance:UserLonInInfo = UserLonInInfo()
        }
        return Static.instance
    }
    
}

//log in
struct LogMessage :Mappable {
    
    var id = ""
    var isAdm = 0
    var pwd = ""
    var headphoto = ""
    var name = ""
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        isAdm <- map["isAdm"]
        pwd <- map["pwd"]
        headphoto <- map["headPhoto"]
        name <- map["name"]
    }
}


struct SystemMessageResponseData : Mappable {

    var list : [LogMessage] = []
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
}


//user info
struct UserMessage :Mappable {
    
    var list : [UserMessageItem] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}


struct UserMessageItem :Mappable {
    
    var id = ""
    var name = ""
    var sex = ""
    var address = ""
    var phoneNumber = ""
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        sex <- map["sex"]
        address <- map["address"]
        phoneNumber <- map["phoneNumber"]
    }
}


struct DisUserInfo {
    var id = ""
    var name = ""
    var sex = ""
    var address = ""
    var phoneNumber = ""
}


//leaveInfo

struct LeaveInfo :Mappable {
    
    var list : [LeaveInfoItem] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
}

struct LeaveInfoItem :Mappable {
    var endTime = ""
    var id = ""
    var location = ""
    var name = ""
    var numberDays = 0
    var proofMaterial = ""
    var reson = ""
    var startTime = ""
    var type = ""
    var leaveMessage = ""
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        endTime <- map["endTime"]
        id <- map["id"]
        location <- map["location"]
        name <- map["name"]
        numberDays <- map["numberDays"]
        proofMaterial <- map["proofMaterial"]
        reson <- map["reson"]
        startTime <- map["startTime"]
        type <- map["type"]
        leaveMessage <- map["leaveMessage"]
    }
}


struct DisLeaveInfo {
    var endTime = ""
    var id = ""
    var location = ""
    var name = ""
    var numberDays = 0
    var proofMaterial = ""
    var reson = ""
    var startTime = ""
    var type = ""
    var leaveMessage = ""
}

//activityInfo
struct activityInfo :Mappable {
    
    var list : [activityInfoItem] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}

struct activityInfoItem :Mappable {
    
    var activityName = ""
    var activityTime = ""
    var activityAddress = ""
    var activityCover = ""
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        activityName <- map["activityName"]
        activityTime <- map["activityTime"]
        activityAddress <- map["activityAddress"]
        activityCover <- map["activityCover"]
    }
    
}


struct DisActivityInfo {
    var activityName = ""
    var activityTime = ""
    var activityAddress = ""
    var activityCover = ""
}


//chang pwd
struct ChangePwdModel :Mappable {
   
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}


//add User
struct AddUserModel :Mappable {
    
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}

//delete User
struct DeleteUserModel :Mappable {
    
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}


//change status
struct ChangeStatusModel :Mappable {
    
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}

//changeUserHeadphoto
struct ChangeUserHeadphotoModel :Mappable {
    
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}

//add activity
struct AddActivityModel :Mappable {
    
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}



//addUserLeaveInfo
struct AddUserLeaveInfoModel :Mappable {
    
    var list : [Int] = []
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["result"]
    }
    
}





