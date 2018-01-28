//
//  FirstViewController.swift
//  SAVUS
//
//  Created by Anshu Rao on 1/27/18.
//

import UIKit
import PusherSwift

class FirstViewController: UITableViewController {
    
    let cellId = "cellId"
    var tweets = [Tweet]()
    var pusher: Pusher! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Crisis Feed"

        tableView.register(TweetCell.self, forCellReuseIdentifier: cellId)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        pusher = Pusher(
            key: "51da1559c29e6c1f86bc"
        )
        
        let channel = pusher.subscribe("hashtags")
        
        let _ = channel.bind(eventName: "new_tweet", callback: { (data: Any?) -> Void in
            if let data = data as? [String : AnyObject] {
                
                // Extract the Tweet information
                let message = data["message"] as! String
                let name = data["name"] as! String
                let username = data["username"] as! String
                
                // Create a tweet
                let tweet = Tweet(name: name, username: username, message: message)
                
                // Insert it at the beginning of the array
                self.tweets.insert(tweet, at: self.tweets.startIndex)
                
                // Insert the new tweet at the beginning of the table and scroll to that position
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.none, animated: true)
            }
        })
        
        pusher.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TweetCell
        
        // At this point, the didSet block will set up the cell's views
        cell.tweet = tweets[indexPath.item]
        
        return cell;
    }

}

