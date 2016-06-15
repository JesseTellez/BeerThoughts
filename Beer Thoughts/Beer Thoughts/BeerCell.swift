//
//  BeerCell.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BeerCell: BasePageCollectionCell {
    
    @IBOutlet weak var backgrondImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alcPercentLabel: UILabel!
    @IBOutlet weak var beerDescription: UITextView!
    @IBOutlet weak var beerType: UILabel!
    
    var request: Request?
    var beer: Beer!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        titleLabel.layer.shadowOpacity = 0.2
        
    }
    
    func configureCell(beer: Beer, img: UIImage?) {
        
        self.beer = beer
        titleLabel.text = beer.beerName
        alcPercentLabel.text = "\(beer.beerPerc)%"
        beerDescription.text = beer.beerDesc
        beerType.text = beer.beerType
        
        //everytime we download an image from the server, we must store it in a cache
        if beer.beerImage != nil {
            
            if img != nil {
                self.backgrondImageView.image = img
            }
            else {
                
               // SDWebImageManager.sharedManager().
                //SDWebImageManager.sharedManager
                
                request = Alamofire.request(.GET, beer.beerImage!).validate(contentType: ["image/*"]).response(completionHandler: {
                    req, res, data, err in
                    
                    if err == nil {
                        dispatch_async(dispatch_get_main_queue(), { 
                            () -> Void in
                              let imgData = UIImage(data: data!)!
                            self.backgrondImageView.image = imgData
                            BeersCollectionVC.imageCache.setObject(imgData, forKey: self.beer.beerImage!)
                        })
                      
                    }
                })
            }
        } else {
            self.backgrondImageView.image = UIImage(named: "loading 2")
        }
    }
}




