//
//  LoginVC.swift
//  SmallDemo
//
//  Created by Sky on 15/10/29.
//  Copyright © 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit

class LoginVC: GlobalVC,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtPWD: UITextField!
    @IBOutlet weak var txtUID: UITextField!
    @IBOutlet weak var btnLogin: UIButton!


    override func RenderDetail() {
        UIHelper.buildButtonFilletStyle(btnLogin, borderColor: UIHelper.mainColor)
        UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "注册")
        
        self.txtUID.delegate = self
        
        self.txtPWD.delegate = self
    }
    
    
    override func ButtonTap(tag: Int) {
        
        if (tag == 10)
        {
            if (self.txtUID.text!.length  == 0 || self.txtPWD.text!.isNullOrEmpty())
            {
                return
            }
            self.view.endEditing(true)
            SVProgressHUD.showWithStatusWithBlack("请稍候")
            
            let postBody = [
                "Mobile": self.txtUID.text!,
                "Password": self.txtPWD.text!
            ]
            self.httpPostApi(AppConfig.ConstUrl.Login, body: postBody, tag: 10)

        }else if (tag == 12)
        {
            self.navigationController?.pushViewController(UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "FindPwdStep1"), animated: true)
 
        }
        
        
    }
    
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (tag == 10) {
            
            if let jsonData = response as? NSDictionary
            {
                
              //  var jsonData=JSON(response)
                
                AppConfig.sharedAppConfig.AccessToken = jsonData.objectForKey("token") as! String
                AppConfig.sharedAppConfig.Portrait = jsonData.objectForKey("Portrait") as! String
                
                AppConfig.sharedAppConfig.save()
                SVProgressHUD.showSuccessWithStatusWithBlack("登录成功");
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.view.window!.rootViewController = storyboard.instantiateInitialViewController()
            }
            
        }
        else if (tag == 11) {
            var dic = response as! NSDictionary
            
            //            var   currUserItem:UserModel! = UserModel(dict: dic);
            //            if(currUserItem != nil && currUserItem.ItemID > 0)
            //            {
            //                dataMgr.saveUserInfo(dic)
            //            }
            //            self.toggleLeftMenu(self);
            //            NSNotificationCenter.defaultCenter().postNotificationName(self.userStatusChangeKey, object: nil)
        }
    }
    

    
    
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        self.navigationController?.pushViewController(UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterVC"), animated: true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField.tag == 1)
        {
            self.txtPWD.becomeFirstResponder()
        }else if (textField.tag == 2)
        {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
