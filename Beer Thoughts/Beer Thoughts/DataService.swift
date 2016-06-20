//
//  DataService.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/20/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import Alamofire

class DataService {
    
    static let ds = DataService()
    
    func downloadAllBeerData (completed: (beers: NSArray) -> ()) {
        
        var array: NSArray = NSArray()
        
        Alamofire.request(.GET, "\(URL_BASE)\(URL_BEERS)", parameters: nil).responseJSON(options: NSJSONReadingOptions.AllowFragments) { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                array = dict["beers"] as! NSArray
                completed(beers: array)
            }
        }
    }
    
}