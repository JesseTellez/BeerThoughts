//
//  BeerCell.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import UIKit
import expanding_collection

class BeerCell: BasePageCollectionCell {
    
    @IBOutlet weak var backgrondImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alcPercentLabel: UILabel!
    @IBOutlet weak var beerDescription: UITextView!
    @IBOutlet weak var beerType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(beer: Beer) {
        
    }
    
}




