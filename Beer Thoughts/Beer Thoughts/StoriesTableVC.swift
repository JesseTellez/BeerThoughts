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
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureNavbar()
        
        
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
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //    if scrollView.contentOffset.y < -25 {
        //      // buttonAnimation
        //      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        //
        //      for viewController in viewControllers {
        //        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
        //          rightButton.animationSelected(false)
        //        }
        //      }
        //      popTransitionAnimation()
        //    }
        
        scrollOffsetY = scrollView.contentOffset.y
    }
}
