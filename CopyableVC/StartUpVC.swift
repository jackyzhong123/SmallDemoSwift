//
//  StartUpVC.swift
//  SmallDemo
//
//  Created by Sky on 15/10/24.
//  Copyright © 2015年 HuoDongOrganizer. All rights reserved.
//



class StartUpVC: GlobalVC,UIScrollViewDelegate {
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var advScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var bpttpnCpnstraint:NSLayoutConstraint!
    
    var currentPageNumber = 0
    var otherPageNumber = 0
    
    var viewWidth: CGFloat = 0.0

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadDLaunchView()
        
        
        //设置Btn圆角
        UIHelper.buildButtonFilletStyleWithRadius(btnStart, borderColor: UIHelper.mainColor, radius: 4)
        btnStart.setTitleColor(UIHelper.mainColor, forState: UIControlState.Normal)
        btnStart.hidden = true
        
        
    }
    
    
    func loadDLaunchView()
    {
        let item1 =  UIImage(named: "StartUp01.png")!
        let item2 =  UIImage(named: "StartUp02.png")!
        let item3 =  UIImage(named: "StartUp03.png")!
        let items = [item1, item2, item3]
        
        pageControl.numberOfPages = items.count;
        
        pageControl.currentPage = 0;
        
        self.advScrollView.showsHorizontalScrollIndicator = false
        self.advScrollView.pagingEnabled = true
        self.advScrollView.delegate = self
        self.advScrollView.bounces = false
        
        self.viewWidth = self.view.frame.size.width
        
        for (index , item) in items.enumerate() {
            let imageView:UIImageView = UIImageView (frame: CGRectMake((self.view.frame.size.width * CGFloat(index)), 0.0, self.viewWidth, self.view.frame.size.height))
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            
            imageView.image = item
            
            advScrollView.addSubview(imageView)
            
        }
        
        self.advScrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(items.count), self.view.frame.size.height)
        
        
    }
    
    
    @IBAction func btnSkipTapped(sender: AnyObject) {
        
         self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        self.currentPageNumber = Int(scrollView.contentOffset.x)/Int(scrollView.frame.size.width)
        
        pageControl.currentPage = self.currentPageNumber
        
        if(pageControl.currentPage == 2)
        {
            btnStart.hidden = false
        }
        else
        {
            btnStart.hidden = true
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var multiplier:CGFloat = 1.0
        let offset:CGFloat = scrollView.contentOffset.x
        
    }
    
    
    

}
