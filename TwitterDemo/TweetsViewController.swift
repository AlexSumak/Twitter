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
    var count = 20
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance?.homeTimeLine(count: count, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}



extension TweetsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    
    
}

