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

class BeerCell: BasePageCollectionCell, SDWebImageManagerDelegate {
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alcPercentLabel: UILabel!
    @IBOutlet weak var beerDescription: UITextView!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var customImageView: CustomImageView!
    
    private var newSize = CGSize(width: 240, height: 249)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SDWebImageManager.sharedManager().delegate = self
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        titleLabel.layer.shadowOpacity = 0.2
        
    }
    
    func configureCell(beer: Beer) {
        
        titleLabel.text = beer.beerName
        alcPercentLabel.text = "\(beer.beerPerc)%"
        beerDescription.text = beer.beerDesc
        beerType.text = beer.beerType
        
        if beer.beerImage != nil {
                
            let url = NSURL(string: beer.beerImage!)
            
            SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions.CacheMemoryOnly, progress: { (recievedSize, expectedSize) in
                
//                self!.customImageView.progressIndicatorView.progress = CGFloat(recievedSize)/CGFloat(expectedSize)
                
                }, completed: { (image, error, cacheType, _, _) in
                    
                    if error == nil {
        
                        dispatch_async(dispatch_get_main_queue(), { [weak self]
                            () -> Void in
                            self!.beerImageView.image = image
                            //self!.customImageView.progressIndicatorView.reveal()
                        })
                    }
            })
        }
    }
    
    
    func imageManager(imageManager: SDWebImageManager!, transformDownloadedImage image: UIImage!, withURL imageURL: NSURL!) -> UIImage! {
        let newImage = UIImage.resizeImage(image)
        return newImage
    }
}




