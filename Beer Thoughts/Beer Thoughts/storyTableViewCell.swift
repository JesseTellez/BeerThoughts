//
//  storyTableViewCell.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/15/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import UIKit

class storyTableViewCell: UITableViewCell {

    @IBOutlet weak var storyText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    //maybe a collection of images in the cell?
    
    func configureCell(story: Story) {
        
    }
    
}
