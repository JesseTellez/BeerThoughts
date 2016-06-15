//
//  TestVC.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/11/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import UIKit
import Alamofire

class TestVC: UIViewController {
    
    
    var beersIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOneDamnThing()
    }
    
    func getOneDamnThing() {
        let newBeer = Beer(id: "ipa")
        newBeer.downloadBeerData {
            print(newBeer.beerName)
        }
    }
    
    func downloadData() {
        
        let url = NSURL(string: "\(URL_BASE)\(URL_BEERS)")
        Alamofire.request(.GET, url!).responseJSON {
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let beers = dict["beers"] as? [Dictionary<String, AnyObject>] where beers.count > 0 {
                    
                    for beer in beers {
                        if let id = beer["id"] as? String where id != ""{
                            self.beersIdArray.append(id)
                        }
                        else {
                            print("Could not add id")
                        }
                    }
                    print(self.beersIdArray)
                }
                else {
                    print("Something Wrong!")
                }
            }
        }
    }
    
}
