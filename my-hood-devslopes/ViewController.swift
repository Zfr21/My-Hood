//
//  ViewController.swift
//  my-hood-devslopes
//
//  Created by Zafer Celaloglu on 27.12.2015.
//  Copyright © 2015 Zafer Celaloglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

//    var mytestArray = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        let dataService = DataService.instance
//        dataService.loadPosts()
//        mytestArray = dataService.loadedPosts

        DataService.instance.loadPosts()

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let post = DataService.instance.loadedPosts[indexPath.row] //mytestArray[indexPath.row] //
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 85.0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count //mytestArray.count //
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            let removedIndex = indexPath.row
//            var array = DataService.instance.loadedPosts
//            let post = array[indexPath.row] // I think this is unnecessary :)
            //array.removeAtIndex(removedIndex)
            //DataService.instance.removePost(removedIndex)
            let imageToDeletePath = DataService.instance.loadedPosts[removedIndex].imagePath
            DataService.instance.loadedPosts.removeAtIndex(removedIndex)
            //mytestArray.removeAtIndex(removedIndex)
            let indexPath = NSIndexPath(forItem: removedIndex, inSection: 0)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            DataService.instance.deletePost(imageToDeletePath)
            tableView.reloadData()
        }
    }

    func onPostsLoaded(notif: AnyObject){
        tableView.reloadData()
    }

}

