//
//  CustomImageView.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/16/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        addSubview(self.progressIndicatorView)
        progressIndicatorView.frame = bounds
        progressIndicatorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
}
