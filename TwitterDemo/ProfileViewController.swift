//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by  Alex Sumak on 3/1/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var numOfTweets: UILabel!
    @IBOutlet weak var numOfFollowing: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
   var tweets: [Tweet]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ddddddddda")
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
