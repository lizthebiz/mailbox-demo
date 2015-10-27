//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Liz Dalay on 10/20/15.
//  Copyright © 2015 Liz Dalay. All rights reserved.
//

import UIKit
import MessageUI

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var mailboxView: UIView!
    
    @IBOutlet weak var feedScrollView: UIScrollView!
    
    @IBOutlet weak var feedView: UIView!
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messagePanGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var laterIconImageView: UIImageView!
    
    @IBOutlet weak var listIconImageView: UIImageView!
    
    @IBOutlet weak var deleteIconImageView: UIImageView!
    
    @IBOutlet weak var archiveIconImageView: UIImageView!
    
    @IBOutlet weak var rescheduleImageView: UIImageView!
    
    @IBOutlet weak var rescheduleTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var listImageView: UIImageView!
    
    @IBOutlet weak var listTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    @IBOutlet weak var edgePanGesture: UIScreenEdgePanGestureRecognizer!
    
    var messageInitialFrame: CGPoint!
    var feedInitialFrame: CGPoint!
    var mailboxInitialFrame: CGPoint!
    
    var laterIconInitialFrame: CGPoint!
    var listIconInitialFrame: CGPoint!
    var deleteIconInitialFrame: CGPoint!
    var archiveIconInitialFrame: CGPoint!
    
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
        rescheduleImageView.alpha = 0
        listImageView.alpha = 0
        
        feedScrollView.contentSize = CGSize(width: 320, height: 1387)
        
        let messagePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onLeftPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        messageImageView.addGestureRecognizer(messagePanGestureRecognizer)
        
        let rescheduleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTapReschedule:")
        
        rescheduleTapGestureRecognizer.numberOfTapsRequired = 1;
        
        rescheduleImageView.userInteractionEnabled = true
        rescheduleImageView.addGestureRecognizer(rescheduleTapGestureRecognizer)
        
        let listTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTapList:")
        
        listTapGestureRecognizer.numberOfTapsRequired = 1;
        
        listImageView.userInteractionEnabled = true
        listImageView.addGestureRecognizer(listTapGestureRecognizer)
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        mailboxView.userInteractionEnabled=true
        edgePanGesture.edges = UIRectEdge.Left
        mailboxView.addGestureRecognizer(edgePanGesture)
        
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
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            
            messageInitialFrame = messageImageView.frame.origin
            
            feedInitialFrame = feedImageView.frame.origin
            
            laterIconInitialFrame = laterIconImageView.frame.origin
            listIconInitialFrame = listIconImageView.frame.origin
            deleteIconInitialFrame = deleteIconImageView.frame.origin
            archiveIconInitialFrame = archiveIconImageView.frame.origin
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            if messageImageView.frame.origin.x > 0 && messageImageView.frame.origin.x <= 60 {
                messageView.backgroundColor = UIColorFromRGB(0xE5E6E9)
                
                UIView.animateWithDuration(0.8, animations: {
                self.archiveIconImageView.alpha = 1
                })
            }
            else if messageImageView.frame.origin.x >= 60 && messageImageView.frame.origin.x < 260 {
                messageView.backgroundColor = UIColorFromRGB(0x1ED200)
                self.archiveIconImageView.alpha = 1
                self.deleteIconImageView.alpha = 0
                
                self.archiveIconImageView.frame.origin.x = CGFloat(self.archiveIconInitialFrame.x + translation.x - 60)
            }
            else if messageImageView.frame.origin.x >= 260 {
                messageView.backgroundColor = UIColorFromRGB(0xFF0000)
                self.archiveIconImageView.alpha = 0
                self.deleteIconImageView.alpha = 1
                
                self.deleteIconImageView.frame.origin.x = CGFloat(self.deleteIconInitialFrame.x + translation.x - 260)
            }
            else if messageImageView.frame.origin.x < 0 && messageImageView.frame.origin.x >= -60 {
                messageView.backgroundColor = UIColorFromRGB(0xE5E6E9)
                
                UIView.animateWithDuration(0.8, animations: {
                    self.laterIconImageView.alpha = 1
                })
            }
            else if messageImageView.frame.origin.x < -60 && messageImageView.frame.origin.x > -260 {
                messageView.backgroundColor = UIColorFromRGB(0xFECA16)
                self.laterIconImageView.alpha = 1
                self.listIconImageView.alpha = 0
                
                self.laterIconImageView.frame.origin.x = CGFloat(self.laterIconInitialFrame.x + translation.x + 62)
            }
            else if messageImageView.frame.origin.x < -260 {
                messageView.backgroundColor = UIColorFromRGB(0xDBAA82)
                self.laterIconImageView.alpha = 0
                self.listIconImageView.alpha = 1
                
                self.listIconImageView.frame.origin.x = CGFloat(self.listIconInitialFrame.x + translation.x + 270)
            }
            
            messageImageView.frame.origin.x = CGFloat(messageInitialFrame.x + translation.x)
            print("\(messageImageView.frame.origin.x)")
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            if messageImageView.frame.origin.x > 0 && messageImageView.frame.origin.x <= 60 {
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    
                    self.messageView.backgroundColor = self.UIColorFromRGB(0xE5E6E9)
                    self.laterIconImageView.alpha = 1
                    self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x)
                    
                    }, completion: nil)
                }
            
            else if messageImageView.frame.origin.x >= 60 && messageImageView.frame.origin.x < 260 {
                self.archiveIconImageView.alpha = 0
                self.deleteIconImageView.alpha = 0
                
                UIView.animateWithDuration(0.3) { () -> Void in
                self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x + 400)
                self.feedImageView.frame.origin.y = CGFloat(self.feedInitialFrame.y - 86)
                }
                UIView.animateWithDuration(0.1) { () -> Void in self.messageView.alpha = 0
                }
            }
            else if messageImageView.frame.origin.x >= 260 {
                messageView.backgroundColor = UIColorFromRGB(0xFF0000)
                self.archiveIconImageView.alpha = 0
                self.deleteIconImageView.alpha = 1
                
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x + 400)
                    self.feedImageView.frame.origin.y = CGFloat(self.feedInitialFrame.y - 86)
                }
                UIView.animateWithDuration(0.1) { () -> Void in self.messageView.alpha = 0
                }
            }
            else if messageImageView.frame.origin.x < 0 && messageImageView.frame.origin.x > -60 {
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    
                    self.messageView.backgroundColor = self.UIColorFromRGB(0xE5E6E9)
                    self.laterIconImageView.alpha = 1
                    self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x)
                    
                    }, completion: nil)
            }
            else if messageImageView.frame.origin.x <= -60 && messageImageView.frame.origin.x > -260 {
                messageView.backgroundColor = UIColorFromRGB(0xFECA16)
                self.laterIconImageView.alpha = 0
                self.listIconImageView.alpha = 0
                
                UIView.animateWithDuration(0.3) { () -> Void in
                    self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x - 100)
                }
                UIView.animateWithDuration(0.1) { () -> Void in
                    self.messageImageView.alpha = 0
                    self.rescheduleImageView.alpha = 1
                }
            }
            else if messageImageView.frame.origin.x <= -260 {
                messageView.backgroundColor = UIColorFromRGB(0xDBAA82)
                self.laterIconImageView.alpha = 0
                self.listIconImageView.alpha = 1

                UIView.animateWithDuration(0.3) { () -> Void in
                    self.messageImageView.frame.origin.x = CGFloat(self.messageInitialFrame.x - 100)
                }
                UIView.animateWithDuration(0.1) { () -> Void in
                    self.messageImageView.alpha = 0
                    self.listImageView.alpha = 1
                }
            }
            
          }
    }
    
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        print("You've tapped me.")
        UIView.animateWithDuration(0.2) { () -> Void in
            self.rescheduleImageView.alpha = 0
        }
        UIImageView.animateWithDuration(0.25) { () -> Void in
            self.feedImageView.frame.origin.y = CGFloat(self.feedInitialFrame.y - 86)
        }
    }
    
    @IBAction func onTapList(sender: UITapGestureRecognizer) {
        print("Can't tap this.")
        UIView.animateWithDuration(0.2) { () -> Void in
            self.listImageView.alpha = 0
        }
        UIView.animateWithDuration(0.25) { () -> Void in
            self.feedImageView.frame.origin.y = CGFloat(self.feedInitialFrame.y - 86)
        }
    }
    
    func onEdgePan (edgePanGesture: UIScreenEdgePanGestureRecognizer){
        var point = edgePanGesture.locationInView(view)
        var translation=edgePanGesture.translationInView(view)
        print("screen edge called \(mailboxView.frame.origin)")
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } //else {
          //self.showSendMailErrorAlert()
        //}
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["tim@codepath.com"])
        mailComposerVC.setSubject("Ta-da, an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending an e-mail in-app isn't too difficult to figure out, but it does require running the simulator on an actual device.", isHTML: false)
        
        return mailComposerVC
    }
    
    //func showSendMailErrorAlert() {
        //let alertController = UIAlertAction(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle: .Alert)
        // create an OK action
        //let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
       ///}
        
        // add the OK action to the alert controller
        //alertController.addAction(OKAction)
        
        //self.presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        //}
    //}
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
