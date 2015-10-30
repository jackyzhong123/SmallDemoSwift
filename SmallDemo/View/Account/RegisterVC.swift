//
//  RegisterVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
///

import UIKit

class RegisterVC: GlobalVC ,UIAlertViewDelegate {
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var txtPhone: TextBoxView!
    @IBOutlet weak var txtControyID:TextBoxView!
    @IBOutlet weak var btnSelectCID: UIButton!
    var strKeyNote = "CountryCode"
    
    var strControyInfo = "+86中国";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        UIHelper.buildButtonFilletStyle(btnRegister, borderColor: UIHelper.mainColor)
        
        txtControyID.enabled = false;
        
    }
    
    override func ButtonTap(tag: Int) {
        if (tag == 10)
        {
            var things = [Any]()
            var things1 = [AnyObject]()
            things.append("gg")
            things1.append("22")
            things1.append(11)
            things.append(33)
            
            
        }else if (tag == 11)
        {
            if (self.txtPhone.text!.length != 11) {
                return;
            }
            self.view.endEditing(true)
            
            let alertController = UIAlertController(title: "确认手机号码", message: "我们将发送验证码短信到这个号码:\r\n\(self.txtPhone.text!)", preferredStyle: .Alert)
            
            
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "确认", style: .Default) { (action) in
                
                SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
                let parameters = ["m": self.txtPhone.text! ]
                
                
                
                self.httpGetApi(AppConfig.ConstUrl.SendSMS, body:parameters, tag: 11)
                
                
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                
            }

        }
    }
    
       
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
          
                
                let vc:RegisterStep2VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep2VC") as! RegisterStep2VC
                vc.strPhone = self.txtPhone.text!.trim();
                vc.countryID = 0;
                self.navigationController?.pushViewController(vc, animated: true)
                
          
        }
        
    }
    
    
    
    
}
