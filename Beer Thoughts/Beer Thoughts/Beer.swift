//
//  Beer.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import Alamofire

class Beer {
    
    private var _beerName: String!
    private var _beerDescription: String!
    private var _beerPercentage: String!
    private var _beerType: String!
    private var _beerId: String!
    private var _beerULR: String!
    
    private var _beerImageUrl: String?
    private var _beerStories: [Story] = []
    
    var beerName: String {
        if _beerName == nil {
            _beerName = ""
        }
        return _beerName
    }
    
    var beerDesc: String {
        if _beerDescription == nil {
            _beerDescription = "There is no description yet!"
        }
        return _beerDescription
    }
    
    var beerPerc: String {
        if _beerPercentage == nil {
            _beerPercentage = ""
        }
        return _beerPercentage
    }
    
    var beerType: String {
        if _beerType == nil {
            _beerType = ""
        }
        return _beerType
    }
    
    var beerImage: String? {
        return _beerImageUrl
    }
    
    init(id: String) {
        self._beerId = id
        _beerULR = "\(URL_BASE)\(URL_BEERS)\(id)"
    }
    
    init(withDictionary dict: NSDictionary) {
        
        if let id = dict["id"] as? String {
            _beerId = id
        }
        
        if let name = dict["name"] as? String {
            _beerName = name
        }
        
        if let description = dict["description"] as? String {
            _beerDescription = description
        }
        
        if let style = dict["style"] as? String {
            _beerType = style
        }
        
        if let abv = dict["abv"] as? String  {
            _beerPercentage = abv
        }
        
        if let bottleImage = dict["bottle_image"] as? Dictionary<String, AnyObject>
        {
            if let image = bottleImage["original"] as? String {
                _beerImageUrl = image
            }
        }
    }
    
    init(withName: String, percentage: String, type: String, imageUrl: String) {
        _beerName = withName
        _beerPercentage = percentage
        _beerType = type
        _beerImageUrl = imageUrl
        _beerDescription = "There is not description yet!"
    }
    
    class func downloadAllBeerData (completed: DownloadComplete) -> NSArray {
         var beerArray: NSArray = NSArray()
        
        Alamofire.request(.GET, "\(URL_BASE)\(URL_BEERS)", parameters: nil).responseJSON(options: NSJSONReadingOptions.AllowFragments) { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                beerArray = dict["beers"] as! NSArray
                print("THIS IS THE APP ARRAY: \(beerArray)")
            }
            completed()
        }
        return beerArray
    }
    
    func downloadBeerData (completed: DownloadComplete) {
        
        let url = NSURL(string: _beerULR)!
        
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("applcation/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request) { (data, res, err) in
            if let response = res, data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        if let beer = dict["beer"] as? Dictionary<String, AnyObject> {
                            if let name = beer["name"] as? String {
                                self._beerName = name
                            }
                            if let description = beer["description"] as? String {
                                self._beerDescription = description
                            }
                            
                            if let style = beer["style"] as? String {
                                self._beerType = style
                            }
                            
                            if let abv = beer["abv"] as? String {
                                self._beerPercentage = abv
                            }
                            
                            if let bottleImage = beer["bottle_image"] as? Dictionary<String, AnyObject> {
                                if let originalImage = bottleImage["original"] as? String {
                                    self._beerImageUrl = originalImage
                                }
                            }
                        }
                        
                    }
                } catch {
                    print("COULD NOT SERIALIZE JSON")
                }
            }
          completed()
        }.resume()
    }
    
    
    
    
}