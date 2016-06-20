//
//  UIImageView+Resize.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/20/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resizeImage(image: UIImage) -> UIImage{
        
        var actualHeight = image.size.height
        var actualWidth = image.size.width
        let maxHeight: CGFloat = 249.0
        let maxWidth: CGFloat = 240.0
        var imageRatio: CGFloat = actualWidth / actualHeight
        let maxRatio: CGFloat = maxWidth / maxHeight
        let compressionQuality: CGFloat = 0.50
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imageRatio < maxRatio {
                imageRatio = maxHeight / actualHeight
                actualWidth = imageRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imageRatio > maxRatio {
                imageRatio = maxWidth / actualWidth
                actualHeight = imageRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        image.drawInRect(rect)
        let resizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        let newData = UIImageJPEGRepresentation(resizedImage, compressionQuality)
        UIGraphicsEndImageContext()
        
        return UIImage(data: newData!)!
        
    }
}
