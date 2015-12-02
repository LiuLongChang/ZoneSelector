//
//  PopViewTool.swift
//  ZoneSelector
//
//  Created by langyue on 15/12/2.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit

typealias popViewClosure = (string : String) -> Void



let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight =  UIScreen.mainScreen().bounds.size.height


class PopViewTool: NSObject {
    
    var myPopViewClosure : popViewClosure?
    
    
    
    var theView : UIView?
    var bgTapView : UIView?
    
    
    class func shareInstance()->PopViewTool{
        struct single{
            static var predicate : dispatch_once_t = 0
            static var instance : PopViewTool? = nil
        }
        dispatch_once(&single.predicate) { () -> Void in
           single.instance = PopViewTool()
            
        }
        return single.instance!
    }
    
    
    
    func selectZoneFinished(closure: popViewClosure?){
        self.myPopViewClosure = closure
    }
    
    func zoneViewAction(btn:UIButton){
    
        let tool = PopViewTool.shareInstance()
        tool.dismiss()
        
        if(myPopViewClosure != nil){
            myPopViewClosure!(string: (btn.titleLabel?.text)! )
        }
        
    }
    

    func popZoneSelectorInView(view: UIView)->Void{
        
        let tool = PopViewTool.shareInstance()
        if (tool.theView == nil) {
            
            tool.bgTapView = UIView(frame: CGRectMake(0,ScreenHeight,ScreenWidth,ScreenHeight-240))
            tool.bgTapView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction"))
            
            tool.bgTapView!.userInteractionEnabled = true;
            tool.bgTapView!.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
            view.addSubview(tool.bgTapView!)
            
            
            tool.theView = UIView(frame: CGRectMake(0, ScreenHeight, ScreenWidth, 240))
            
            tool.theView!.backgroundColor =  UIColor(red: 217/255.0, green: 222/255.0, blue: 225/255.0, alpha: 1)
            //[tool.dic setObject:block forKey:"Block"];
            
            let arr = ["京","沪","浙","苏","粤","鲁","晋","冀","豫","川","渝","辽","吉","黑","皖","鄂","湘","赣","闽","陕","甘","宁","蒙","津","贵","云","桂","琼","青","新","藏","完成"]
            
            
            let width : Float = 30;
            let height : Float = 40;
            let sep : Float = ( Float(ScreenWidth) - width*9)/10;
            let  sep1 : Float = (200-height*4)/5;
            
            
            for index in 0...arr.count-1{
                let indexFloat = Int(index)
                let btn = UIButton(type: .Custom)
                
                let yv = indexFloat%9 as Int
                let to = indexFloat/9
                
                btn.frame = CGRectMake(   CGFloat(yv * Int((width + sep)) + 5) , CGFloat(to *  Int((height + sep1)) + 10)   , CGFloat(width) , CGFloat(height))
                btn.layer.cornerRadius = 4
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.setTitle(arr[index], forState: .Normal)
                
                let shadowPath : UIBezierPath = UIBezierPath(rect: btn.bounds)
                btn.layer.masksToBounds = false;
                btn.layer.shadowColor = UIColor.blackColor().CGColor;
                btn.layer.shadowOffset = CGSizeMake(0.0, 5.0);
                btn.layer.shadowOpacity = 0.5;
                btn.layer.shadowPath = shadowPath.CGPath;
                
                if (index == arr.count - 1){
                    
                    btn.frame = CGRectMake( CGFloat(Int(view.frame.size.width)-80), CGFloat(10+index/9*Int((height+sep1))),75,CGFloat(height));
                    btn.backgroundColor = UIColor(red: 255/255.0, green: 182/255.0, blue: 41/255.0, alpha: 1)
                    btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    
                }else{
                    
                    btn.setBackgroundImage(UIImage(named: "w.png"), forState: .Normal)
                    btn.setBackgroundImage(UIImage(named: "g.png"), forState: .Normal)
                    
                    
                }
                
                tool.theView?.addSubview(btn)
                btn.addTarget(self, action: "zoneViewAction:", forControlEvents: .TouchUpInside)
                btn.tag = 600 + index
                
            }
            
            
            view.addSubview(tool.theView!)
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                tool.theView!.frame = CGRectMake(0, ScreenHeight-240, ScreenWidth, 240);
                tool.bgTapView!.frame = CGRectMake(0,0,ScreenWidth , ScreenHeight-240);
            })
            
            
        }
        
        
        
    }
    
    
        func tapAction(){
            let tool = PopViewTool.shareInstance()
            tool.dismiss()
        }
        
        
        
        func dismiss(){
            
            let tool = PopViewTool.shareInstance()
            tool.bgTapView?.removeFromSuperview()
            tool.bgTapView = nil
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                tool.theView?.frame = CGRectMake(0, ScreenHeight, ScreenWidth,200);
                
                }) { (finished) -> Void in
                    
                    tool.theView = nil;
            }
            
            
        }
        
        
    
    

}
