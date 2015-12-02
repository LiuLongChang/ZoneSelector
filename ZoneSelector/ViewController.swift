//
//  ViewController.swift
//  ZoneSelector
//
//  Created by langyue on 15/12/2.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var btn : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        btn = UIButton(type: .System)
        btn.backgroundColor = UIColor.blackColor()
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitle("Click Me,Select Zone !", forState: .Normal)
        btn.addTarget(self, action: "zoneSelectAction", forControlEvents: .TouchUpInside)
        btn.frame = CGRectMake(100, 100, 200, 50)
        btn.titleLabel?.font = UIFont.systemFontOfSize(18)
        self.view.addSubview(btn)
        
        
    }
    
    
    func zoneSelectAction(){
        
        let tool = PopViewTool.shareInstance()
        tool.popZoneSelectorInView(self.view)
        tool.selectZoneFinished { (string) -> Void in
            
            print("==========+++++++oooo   \(string)")
            self.btn.setTitle("\(string)", forState: .Normal)
            
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

