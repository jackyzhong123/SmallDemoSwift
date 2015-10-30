//
//  FindPwdStep1.swift
//  SmallDemo
//
//  Created by Sky on 15/10/30.
//  Copyright © 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit

class FindPwdStep1: GlobalVC {

    
    @IBOutlet weak var txtInput: UITextField!
   
    
    override func RenderDetail() {
        txtInput.frame = CGRectMake(txtInput.frame.origin.x, txtInput.frame.origin.y, txtInput.frame.width,44)
    }
    
    
    
    override func ButtonTap(tag: Int) {
        
        if (self.txtInput.text!.length != 11) {
            return;
        }
        
        self.view.endEditing(true)
     
        
        
        
        let alertController = UIAlertController(title: "确认手机号码", message: "我们将发送验证码短信到这个号码:\r\n\(self.txtInput.text!)", preferredStyle: .Alert)
        
        
        
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "确认", style: .Default) { (action) in
            
            SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
            let parameters = ["m": self.txtInput.text! ]
            
            self.httpGetApi(AppConfig.ConstUrl.SendSMS, body:parameters, tag: 11)
            
            
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            
        }

        
        
    }
    
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
            let vc:RegisterStep2VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep2VC") as! RegisterStep2VC
            vc.strPhone = txtInput.text!.trim();
            vc.isFromFindPwd = true;
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func requestDataFailed(error:String)
    {
        SVProgressHUD.showErrorWithStatusWithBlack(error);
    }
    
    

}
