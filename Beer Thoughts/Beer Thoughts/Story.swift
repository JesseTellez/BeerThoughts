//
//  Story.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation


class Story {
    
    private var _title: String!
    private var _story: String!
    private var _date: NSDate!
    
    init(title: String, story: String) {
        
        self._story = story
        self._title = title
        
        getCurrentDate()
        
    }
    
    func getCurrentDate() -> NSDate {
        
        return NSDate()
    }
    
}