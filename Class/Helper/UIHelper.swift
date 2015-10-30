//
//  UIHelper.swift
//  landi-app
//
//  Created by Andy Chen on 6/21/15.
//  Copyright (c) 2015 edonesoft. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
//设备枚举
enum DeviceEnum{
    case iPnone6
    case iPnone6P
    case iPnone5
    case iElse
}
//故事版枚举
enum StoryboardCategory
{
    case Main
    case Account
    case Map
    case Photo
    case Public
    case Order
    case Affair
    case Find
}



class UIHelper {
    
    //首页是否分栏状态
    static var  isMenuOpen = false;
    
    static let Iphone5Height:CGFloat = 568.0;
    static let Iphone6Height:CGFloat = 667.0;
    static let Iphone6PHeight:CGFloat = 736.0;
    //系统主色调{大部分字体颜色 }
    static var mainColor:UIColor = UIColor(red: 88.0/255.0, green: 140.0/255.0, blue: 236.0/255.0, alpha: 1)
    //UIColor(red: 124.0/255.0, green: 183.0/255.0, blue: 217.0/255.0, alpha: 1)
    //带链接的文字颜色
    static var mainLinkColor:UIColor = UIColor(red: 88.0/255.0, green: 140.0/255.0, blue: 236.0/255.0, alpha: 1)
    //表格sesion背景颜色
    static let rowTitleColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
    //系统主字体
    static let mainFont = UIFont(name: "NotoSansHans-Light", size: 15)
    //navigation字体
    static let mainFont10 = UIFont(name: "NotoSansHans-Light", size: 10)
    static let mainFont11 = UIFont(name: "NotoSansHans-Light", size: 11)
    static let mainFont12 = UIFont(name: "NotoSansHans-Light", size: 12)
    static let mainFont13 = UIFont(name: "NotoSansHans-Light", size: 13)
    static let mainFont14 = UIFont(name: "NotoSansHans-Light", size: 14)
    static let mainFont17 = UIFont(name: "NotoSansHans-Light", size: 17)
    static let mainNaviFont22 = UIFont(name: "NotoSansHans-Light", size: 22)
    
    //列表边框，下划线的颜色
    static var layBordeColor:CGColor! = CGColorCreateCopyWithAlpha(UIColor.grayColor().CGColor, 0.3)
    
    
    //事务状态颜色
    static var orderProgressColor:UIColor = UIColor(red: 255.0/255.0, green: 148.0/255.0, blue: 90.0/255.0, alpha: 1)
    static var orderFinishColor :UIColor = UIColor(red: 161.0/255.0, green: 205.0/255.0, blue: 72.0/255.0, alpha: 1)
    
    
    //textLabel文字颜色：
    static var grayColor:UIColor = UIColor.grayColor();
    
    static let defaultImgName = "default_img"
    //通办照片名称
    static let strCommonImgName = "Photo_Common.jpg"
    //最终提交照片的名称
    static let strSubmitImgName = "trueFinal.jpg"
    //验证的时候使用的照片
    static let strVerifyImgName = "TempVerifyImg.jpg"
    static func GetVCWithIDFromStoryBoard(sc:StoryboardCategory, viewControllerIdentity:String) -> UIViewController {
        var sid = ""
        switch(sc)
        {
        case .Account:
            sid="Account"
            break;
        case .Main:
            sid="Main"
            break;
        case .Map:
            sid="Map"
            break;
        case .Photo:
            sid="Photo"
            break;
        case .Public:
            sid="Public"
            break;
        case .Order:
            sid="Order"
            break;
        case .Affair:
            sid="Affair"
            break;
        case .Find:
            sid="Find"
            break;
            
        default:
            sid = "";
            break;
        }
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerIdentity) 
        return vc
    }
    
    static func GetDeviceName()->String{
        var result:String = ""
        
        let name = UnsafeMutablePointer<utsname>.alloc(1)
        uname(name)
        
        let machine = withUnsafePointer(&name.memory.machine, { (ptr) -> String? in
            
            let int8Ptr = unsafeBitCast(ptr, UnsafePointer<Int8>.self)
            result = String.fromCString(int8Ptr)!
            return String.fromCString(int8Ptr)
        })
        
        name.dealloc(1)
                
        let deviceString:NSString =  result as NSString
        if(deviceString.rangeOfString("iPhone3").length>0 || deviceString.rangeOfString("iPhone4").length>0)
        {
            result = "iPhone 4"
        }
        else if(deviceString.isEqualToString("iPhone5,1") || deviceString.isEqualToString("iPhone5,2"))
        {
            result = "iPhone 5"
        }
        else if(deviceString.isEqualToString("iPhone5,3") || deviceString.isEqualToString("iPhone5,4"))
        {
            result = "iPhone 5C"
        }
        else if(deviceString.rangeOfString("iPhone6").length>0)
        {
            result = "iPhone 5S"
        }
        else if(deviceString.isEqualToString("iPhone7,1"))
        {
            result = "iPhone 6 Plus"
        }
        else if(deviceString.isEqualToString("iPhone7,2"))
        {
            result = "iPhone 6"
        }
        else
        {
            result = "IOS unknow"
        }
        return result;
    }
    
    static func GetDeviceModel()->DeviceEnum
    {
        var result = DeviceEnum.iElse;
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone)
        {
            let maxLenght = max(UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
            if(maxLenght == 568.0)
            {
                result = DeviceEnum.iPnone5;
            }
            else  if(maxLenght == 667.0)
            {
                result = DeviceEnum.iPnone6;
            }
            else  if(maxLenght == 736.0)
            {
                result = DeviceEnum.iPnone6P;
            }
        }
        
        return result;
    }
    
    static func resize(orginHeightInIphone5:CGFloat)->CGFloat
    {
        let deviceType = GetDeviceModel()
        var height = orginHeightInIphone5
        if(deviceType == DeviceEnum.iPnone6)
        {
            height = height/UIHelper.Iphone5Height * UIHelper.Iphone6Height;
        }
        else if(deviceType == DeviceEnum.iPnone6P)
        {
            height = height/UIHelper.Iphone5Height * UIHelper.Iphone6PHeight;
        }
        let newHeigt:Int = Int(height)
        return CGFloat(newHeigt);
    }
    static func SetNaviBarLeftItemWithBackImg(targetVC:UIViewController,action:Selector)
    {
        UIHelper.SetNavigationBar(true, targetVC: targetVC, doAction: action, isImg: true, strNname: "navi_back.png",color:mainColor)
    }
    static func SetNaviBarRightItemWithName(targetVC:UIViewController,action:Selector,strName:String)
    {
        UIHelper.SetNavigationBar(false, targetVC: targetVC, doAction: action, isImg: false, strNname: strName,color:mainColor)
    }
    
    static func SetNaviBarRightItemWithIcon(targetVC:UIViewController,action:Selector,strName:String)
    {
        UIHelper.SetNavigationBar(false, targetVC: targetVC, doAction: action, isImg: true, strNname: strName,color:mainColor)
    }
    static func SetNaviBarLeftItemWithIcon(targetVC:UIViewController,action:Selector,strName:String)
    {
        UIHelper.SetNavigationBar(true, targetVC: targetVC, doAction: action, isImg: true, strNname: strName,color:mainColor)
    }
    
    
    static func SetNavigationBar(isLeft:Bool,targetVC:UIViewController,doAction:Selector,isImg:Bool,strNname:String,color:UIColor)
    {
        if(isLeft)
        {
            let btn = UIButton(frame:CGRectMake(0,0,30,20));
            
            if(isImg)
            {
                if (strNname == "navi_back.png")
                {
                      btn.setBackgroundImage( UIImage(named:strNname), forState: UIControlState.Normal)
                }else
                {
                     targetVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:strNname), style: UIBarButtonItemStyle.Plain, target: targetVC, action: doAction)
                    targetVC.navigationItem.leftBarButtonItem!.tintColor = color;
                    return
                }
              
            }
            else
            {
                btn.titleLabel?.font = UIHelper.mainNaviFont22;
                btn.titleLabel?.text = strNname
            }
            btn.addTarget(targetVC, action: doAction, forControlEvents: UIControlEvents.TouchUpInside)
            targetVC.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: btn);
            targetVC.navigationItem.leftBarButtonItem!.tintColor = color;
        }
        else
        {
            
            if(isImg)
            {
                targetVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:strNname), style: UIBarButtonItemStyle.Plain, target: targetVC, action: doAction)
            }
            else
            {
                targetVC.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: strNname, style: UIBarButtonItemStyle.Plain, target: targetVC, action: doAction)
            }
            targetVC.navigationItem.rightBarButtonItem!.tintColor = color;
        }
    }
    
    /*
    生成圆角按钮
    */
    static func buildButtonFilletStyle(btn:UIButton,borderColor:UIColor)
    {
        self.buildButtonFilletStyleWithRadius(btn,borderColor:borderColor,radius:6);
    }
    static func buildButtonFilletStyleWithRadius(btn:UIButton,borderColor:UIColor,radius:CGFloat)
    {
        self.buildButtonFilletStyleWithRadius(btn, borderColor: borderColor, titleColor: mainColor, radius: radius);
    }
    static func buildButtonFilletStyleWithRadius(btn:UIButton,borderColor:UIColor,titleColor:UIColor,radius:CGFloat)
    {
        btn.layer.cornerRadius = radius;
        btn.layer.masksToBounds=true
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = borderColor.CGColor;
        btn.setTitleColor(titleColor, forState: UIControlState.Normal)
        
        btn.titleLabel?.font = UIHelper.mainFont14;
    }
    
    
 
   
    
    
    static func getCachedFilePath(relative:String)->String!
    {
        var strResult = "";
        let paths:NSArray=NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        let root:String = paths.count>0 ? paths.objectAtIndex(0) as! String:"undefined";
        strResult = root + "/" + relative
        return strResult
        
    }
    static func getBundledImage(name:String)->UIImage
    {
        
        let strResure =  NSBundle.mainBundle().pathForResource(name, ofType: nil)
        return UIImage(contentsOfFile:strResure!)!
        //    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
    }
}