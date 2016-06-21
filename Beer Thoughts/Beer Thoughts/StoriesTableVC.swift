//
//  StoriesTableVC.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import UIKit

class StoriesTableVC: ExpandingTableViewController {
    
    private var scrollOffsetY: CGFloat = 0
    var beer: String! = ""
    var stories: [Story]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = self.beer where name != "" {
            print("My Beer is: \(self.beer)")
        }
        
        configureNavbar()
    }
}

extension StoriesTableVC {
    func configureNavbar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}

extension StoriesTableVC {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("storyCell", forIndexPath: indexPath) as! storyTableViewCell
        
        return cell
    }
}

extension StoriesTableVC {
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        let viewControllers: [BeersCollectionVC?] = navigationController?.viewControllers.map { $0 as? BeersCollectionVC} ?? []
        
        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimationBarButton {
                rightButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
    
}



extension StoriesTableVC {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        scrollOffsetY = scrollView.contentOffset.y
    }
}
