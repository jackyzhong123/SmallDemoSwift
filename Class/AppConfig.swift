//
//  AppConfig.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit





class AppConfig: NSObject {

    //MARK: 一些变量
    var AccessToken:String = ""
    var MySex:Int = 2
    var Portrait = ""
    
    
    //填充各个字段
    func fillObject(dic:Dictionary<String, AnyObject>)
    {
        if ((dic["AccessToken"] as? String) != nil)
        {
            self.AccessToken = dic["AccessToken"] as! String
        }
        
        if ((dic["MySex"] as? Int) != nil)
        {
            self.MySex = dic["MySex"] as! Int
        }
        
        if ((dic["Portrait"] as? String) != nil)
        {
            self.Portrait = dic["Portrait"] as! String
        }
        
    }
    
    
    //将局部变量的值保存到 UserDefaults 中
    func save()->Bool
    {
        let ud = NSUserDefaults.standardUserDefaults()
        
        let obj : [String : AnyObject] = [
            "AccessToken" : self.AccessToken,
             "MySex": self.MySex,
            "Portrait":self.Portrait
            
        ]
        
    
        
        
     //   let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
        ud.setObject(obj, forKey: "Configuration")
        
        ud.synchronize()
        
        self.load()
        return true
    }
    
    
    
    
    
    
 
    //MARK: 一些Url的配置
    class ConstUrl
    {
        
        
        //MARK: 一些整体的配置
       // static let SERVICE_ROOT_PATH = "http://192.168.1.26:47897/"
      //  static let SERVICE_ROOT_PATH = "http://smalldemo.chinacloudsites.cn/"
        static let SERVICE_ROOT_PATH = "http://192.168.1.119:63193/"

        
        //MARK: 一些 Copyable Url 的配置
        //MARK: Url_SSO
        //手机号登录
        static let  Login = "api/sso/login"
        
        //重置密码
        static let ResetPwd = "api/sso/password/reset"
        
        //用户注册
        static let Register = "api/sso/register"
        
        //更换头像
        static let changeUserPortrait = "api/sso/profile/portrait/change"
        
        //MARK: Url_System
        //发送短信
        static let SendSMS = "api/system/vcode/send/sms"
        
        //短信验证
        static let SMSVerify = "api/system/vcode/verify/sms"
        
        //上传头像
        static let uploadImage="api/UploadImage"
        
        //获得用户档案
        static let getProfile="api/Login/getProfile"
        
        
        
       
        
        //获取我的专辑
        static let getMyAlbumList="api/HuoDongService/getMyAlbumList"
        
        //增加新的专辑
        static let AddNewAlbum="api/HuoDongService/AddNewAlbum"
        
        //获得我的地点
        static let getMyLocationList="api/HuoDongService/getPlaceList"
        
       
        
        
        
       
        
        //获取我收藏的地址或创建的地址
        static let MyLocationList = "api/HuoDongService/getPlaceList"
        
        //MARK: 一些 非Copyable Url的配置
        //新增活动
        static let AddActivity = "api/Activity/Create"
        
        static let MyActivityList = "api/Activity/MyActivityList"
        
        static let PersonRegister = "api/Login/PersonRegister"
        
        static let PersonLogin = "api/Login/PersonLogin"
        
        static let ChangeRealName = "api/Login/ChangeRealName"
        
        static let ChangeSex = "api/Login/ChangeSex"
        
        static let ChangeHDYName = "api/Login/ChangeHDYName"
        
        static let ActivityList = "api/Activity/ActivityList"
        
        static let LocationList = "api/Activity/LocationList"
        
        static let AlbumList = "api/Activity/AlbumList"
        
        static let PersonList = "api/Contact/PersonList"
        
        static let OrgList = "api/Contact/OrgList"
        
        static let MyFollwerAndLocation = "api/Contact/MyFollowingAndLocation"
        
        static let MakeFavLocation = "api/Contact/MakeFavLocation"
        
        static let MakeFollow = "api/Contact/MakeFollow"
        
        static let testget = "api/test/get"
        static let testpost = "api/test/post"

    }
    
    
    //Mark: 一些notification字符串
    class ConstNotification
    {
        static let SelectAlbum = "SelectAlbum"
        static let SelectLocation = "SelectLocation"
        static let ChangeUerProfile = "ChangeUerProfile"
        static let ReloadUserInfo = "ReloadUserInfo_Notiication"
        static let UserLogout = "user-login-logout"
        
    }
    
    
    //Mark: 一些静态函数
    class ConstFuc
    {
        // NSData -> NSDictionary
        static func C_NSData2Dictionary(data:NSData) -> AnyObject
        {
            
            
            return try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        }
        
        // NSDictionary -> NSData
        static func C_Dictionary3NSData(data:NSDictionary) -> NSData
        {
            
            let dataExample : NSData = NSKeyedArchiver.archivedDataWithRootObject(data)
            return dataExample
        }
    }
  
    
    
    //MARK:- 单例模式
    
    
    
//    class   var sharedAppConfig : AppConfig {
//        struct Static {
//            static var onceToken : dispatch_once_t = 0
//            static var instance : AppConfig? = nil
//        }
//        dispatch_once(&Static.onceToken) {
//            Static.instance = AppConfig()
//        }
//        return Static.instance!
//    }
    
    
    
    //MARK:- 单例模式
    class var sharedAppConfig: AppConfig {
        struct Static {
            static var instance : AppConfig?
            static var token : dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = AppConfig()
        }
        return Static.instance!
        
    }
    
   
   
    
    //MARK: 一些函数
    func isUserLogin()->Bool
    {
        return !self.AccessToken.isNullOrEmpty()
    }
    
    func getAuthorizationString()->String
    {
        return String(format: "Bearer %@",AppConfig.sharedAppConfig.AccessToken)
    }
    
    func syncUserInfo(data : AnyObject)
    {
        let varData = data as! NSData;
        let dataDir:NSDictionary =  (try! NSJSONSerialization.JSONObjectWithData(varData, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
        
        fillObject(dataDir as! Dictionary<String, AnyObject>)
        
        AppConfig.sharedAppConfig.save()
        NSNotificationCenter.defaultCenter().postNotificationName(ConstNotification.ReloadUserInfo, object: nil)
    }
    
    
    
    func userLogout()
    {
        self.AccessToken = ""
        self.save()
        
        NSNotificationCenter.defaultCenter().postNotificationName(ConstNotification.UserLogout, object: nil, userInfo: nil)
    }
    
    
    
    //MARK:其他
    override init()
    {
        super.init();
        self.load()
    }
    
    
    
    //将 UserDefaults 中的值释放到局部变量中
    func load()
    {
        let ud = NSUserDefaults.standardUserDefaults()
        
        if let Configration = ud.dictionaryForKey("Configuration")
        {
           fillObject(Configration)
        }
    
    }
    
    
    func getIsNeedShowLanuchPage()->Bool
    {
        
        let strKey = "IsNeedShowLanuchPage"
        var result = true
        let defaults = NSUserDefaults.standardUserDefaults();
        
        if(defaults.objectForKey(strKey) != nil)
        {
            result = defaults.objectForKey(strKey) as! Bool
        }
        return result;
    }
    
    func setIsNeedShowLanuchPage(isneed:Bool)
    {
        let strKey = "IsNeedShowLanuchPage"
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(isneed, forKey: strKey)
    }

    
    
    
}
