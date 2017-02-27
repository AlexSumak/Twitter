//
//  Tweet.swift
//  TwitterDemo
//
//  Created by  Alex Sumak on 2/25/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var userName: String?
    var id_str: String?
    
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    
    
    init(dictionary: NSDictionary){
        
        text = dictionary["text"] as? String
        userName = dictionary["user"] as? String
        id_str = dictionary["id_str"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
    
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
    }
    
}



