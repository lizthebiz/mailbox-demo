//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Liz Dalay on 10/20/15.
//  Copyright © 2015 Liz Dalay. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var feedScrollView: UIScrollView!
    
    @IBOutlet weak var feedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        feedScrollView.contentSize = CGSize(width: 320, height: 1387)
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

}
