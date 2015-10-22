//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Liz Dalay on 10/20/15.
//  Copyright © 2015 Liz Dalay. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var feedScrollView: UIScrollView!
    
    @IBOutlet weak var feedView: UIView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messagePanGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var messageImageView: UIImageView!
    
    var messageInitialFrame: CGPoint!
    var messageLeft: CGPoint!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        feedScrollView.contentSize = CGSize(width: 320, height: 1387)
        
        var messagePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onLeftPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        messageImageView.addGestureRecognizer(messagePanGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLeftPan(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view
        let point = sender.locationInView(view)
        // Relative change in (x,y) coordinates from where gesture began.
        let messageTranslation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            messageInitialFrame = messageImageView.frame.origin
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            if messageImageView.frame.origin.x >= 60 {
            messageView.backgroundColor = UIColorFromRGB(0x1ED200)}
            
            if messageImageView.frame.origin.x >= 260 {
            messageView.backgroundColor = UIColorFromRGB(0xFF0000)}
            
            messageImageView.frame.origin.x = CGFloat(messageInitialFrame.x + messageTranslation.x)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x)
                self.messageView.backgroundColor = self.UIColorFromRGB(0xE5E6E9)
                
                }, completion: nil)
        }
    }

}
