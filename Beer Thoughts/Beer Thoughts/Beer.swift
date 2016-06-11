//
//  Beer.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation

class Beer {
    
    private var beerName: String!
    private var beerImageUrl: String!
    private var beerDescription: String!
    private var beerPercentage: Float!
    private var beerType: String!
    private var beerStories: [Story] = []
    
    init(name: String, imgurl: String?, description: String, percetage: Float, type: String) {
        beerName = name
        beerImageUrl = imgurl
        beerDescription = description
        beerPercentage = percetage
        beerType = type
    }
    
    
    
    
}