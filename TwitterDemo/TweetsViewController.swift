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

    
    
    @IBAction func retweet(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let tweet = tweets[(indexPath?.row)!]
        if tweet.retweeted! {
            TwitterClient.sharedInstance?.unretweet(tweet: tweet, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.count, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("unretweeted")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        } else {
            TwitterClient.sharedInstance?.retweet(tweet: tweet, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.count, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("retweeted")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
        
    }
    
    
    @IBAction func like(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let tweet = tweets[(indexPath?.row)!]
        if tweet.favorited! {
            TwitterClient.sharedInstance?.unfavorite(tweet: tweet, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.count, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("unfavorited")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        } else {
            TwitterClient.sharedInstance?.favorite(tweet: tweet, success: { (tweet: Tweet) -> () in
                TwitterClient.sharedInstance?.homeTimeLine(count: self.count, success: { (tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: { (error: Error) -> () in
                    print(error.localizedDescription)
                })
                print("favorited")
            }, failure: { (error: Error) -> () in
                print(error.localizedDescription)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func timeAgoSince(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        
        return "Just now"
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
        if let imageUrlString = tweet.profileImageUrlString {
        let imageUrl = URL(string: imageUrlString)
            cell.profileImageView.setImageWith(imageUrl!)
        }
        
        cell.likeLabel.text = tweet.favoriteCount.description
        cell.repostLabel.text = tweet.retweetCount.description
        cell.timeLabel.text = timeAgoSince(tweet.timestamp!)
        cell.tweetTextLabel.text = tweet.text
        cell.nameLabel.text = tweet.userName
        return cell
    }

    
    
}
