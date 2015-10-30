//
//  FirstViewController.swift
//  SmallDemo
//
//  Created by Sky on 15/10/23.
//  Copyright © 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit

class FirstViewController: GlobalVC {

    @IBOutlet var lblName: UILabel!
    @IBAction func btnAction(sender: AnyObject) {
        
        let parameter = [
            "xx": "zhong",
            "uu": 11
        ]
        
        self.httpPostApi(AppConfig.ConstUrl.testpost, body: parameter, tag: 11)
        
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
      
        
        if(AppConfig.sharedAppConfig.getIsNeedShowLanuchPage())
        {
            
            let  vc = UIHelper.GetVCWithIDFromStoryBoard(.Public, viewControllerIdentity: "StartUpVC")
            
            AppConfig.sharedAppConfig.setIsNeedShowLanuchPage(false);
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tabBarItem.title = "ddd"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

