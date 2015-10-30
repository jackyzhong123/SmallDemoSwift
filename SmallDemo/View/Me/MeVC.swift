//
//  MeVC.swift
//  SmallDemo
//
//  Created by Sky on 15/10/30.
//  Copyright © 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit

class MeVC: GlobalVC,UITableViewDataSource, UITableViewDelegate {
 
//    override func ButtonTap(tag: Int) {
//        
//        AppConfig.sharedAppConfig.userLogout()
//        let vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "LoginVC")
//        let navi =  UINavigationController(rootViewController: vc)
//        self.view.window?.rootViewController = navi
//       
//    }
    
    
    
    
    //MARK: 页面变量
    @IBOutlet var tableView: UITableView!
    let headCell = "MeHeaderCell"
    let generalCell = "Cell"
    let iconArr = []
    let titleArr = []
    
    
 
    
    override func RenderDetail() {
        self.title = "我的"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeUserStatus:", name: AppConfig.ConstNotification.ChangeUerProfile, object: nil)
    }
    
    func changeUserStatus(notification:NSNotification)
    {
        tableView.reloadData();
        
        
    }
    
    
    override func ButtonTap(tag: Int) {
        if (tag == 10)
        {
            
        }
    }
    
    
    
   
    
    //MARK: 网络调用
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        
    }
    
    
    //MARK: 数据绑定
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 88
        }
        return 44
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
            return 1
        }
        else
        {
            return self.iconArr.count
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0)
        {
            let headcell:MeHeaderCell = self.tableView.dequeueReusableCellWithIdentifier(self.headCell) as! MeHeaderCell
            
            headcell.lbName.text = "ddd"
            headcell.lbPersonHDYName.text = "gg"
            headcell.imgCover!.sd_setImageWithURL(NSURL(string:AppConfig.sharedAppConfig.Portrait)!, placeholderImage: UIImage(named: "placeholder.png"))
            let layer:CALayer = headcell.imgCover.layer
            layer.cornerRadius = 10
            layer.masksToBounds = true
            return headcell;
        }
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(self.generalCell)!
        if (indexPath.section == 1 )
        {
            cell.textLabel?.text = titleArr [indexPath.row] as? String
            cell.imageView?.image = UIImage(named: iconArr[indexPath.row] as! String)
            
            
            return cell;
            
            
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 0 )
        {
            let vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "ProfileVC")
            self.navigationController?.pushViewController(vc, animated: true)
            
            tableView.cellForRowAtIndexPath(indexPath)?.selectionStyle = UITableViewCellSelectionStyle.None
            
         
            return
        }else
        {
            
            //注销
            AppConfig.sharedAppConfig.userLogout()
            let vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "loginNavigation")
            
            self.view.window?.rootViewController = vc
            
        }
    }
    
    
    
    
    

    

}
