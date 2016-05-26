//
//  SegmentController.swift
//  BS
//
//  Created by 姚驷旭 on 16/1/20.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import ReactiveCocoa
import CocoaLumberjack
class SegmentedViewController: UIViewController {
    
    var myViewControllers : [UIViewController] = [] {
        
        didSet {
            initialize()
        }
    }
    
    var segmentController : UISegmentedControl? = nil
    var currentViewController :UIViewController? = nil {
        didSet {
            self.navigationItem.leftBarButtonItem = currentViewController?.navigationItem.leftBarButtonItem
            self.navigationItem.rightBarButtonItem = currentViewController?.navigationItem.rightBarButtonItem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.z
        
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.backBarButtonItem =  UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    func initialize() {
        
        myViewControllers.forEach {[weak self] in
            $0.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
            self?.addChildViewController($0)
        }
        let items = myViewControllers.flatMap {
            //            DDLogDebug("title:\($0.title)")
            return $0.segmentTitle
        }
        
        currentViewController = myViewControllers[0]
        view.addSubview(currentViewController!.view)
        
        segmentController = UISegmentedControl(items: items)
        segmentController?.setWidth(80, forSegmentAtIndex: 0)
        segmentController?.setWidth(80, forSegmentAtIndex: 1)
        segmentController?.rac_newSelectedSegmentIndexChannelWithNilValue(nil).subscribeNext {[weak self] in
            DDLogDebug("segmentController changed index:\($0)")
            if let index = $0 as? Int ,
                let toViewController = self?.myViewControllers[index],
                let currentVC = self?.currentViewController {
                    self?.transitionFromViewController(currentVC, toViewController: toViewController, duration: 0,
                        options: [], animations: nil, completion: { _ in
                            self?.currentViewController = toViewController
                    })
            }
        }
        segmentController?.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentController
        
    }
    
    override func viewDidLayoutSubviews() {
        DDLogVerbose("segmentViewController.frame:\(self.view.frame)")
    }
    //    override func vviewWillLayoutSubviews() {
    //        myViewControllers.forEach {[weak self] in
    //            $0.view.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height－64 - 10)
    //        }
    //    }
    //
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    private struct AssociatedKeys {
        static var segmentTitleKey   = "segmentTitle"
    }
    
    var segmentTitle : AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.segmentTitleKey)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.segmentTitleKey, (newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
