//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by  Alex Sumak on 2/25/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    
    var tweets: [Tweet]!
    var count = 40
    @IBOutlet weak var tableView: UITableView!
    

    @IBAction func onLogoutButton(_ sender: Any) {
    }
    

    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        
        TwitterClient.sharedInstance?.homeTimeLine(count: count, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            /*
             for tweet in tweets {
             print(tweet.text)
             }
             */
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
