//
//  AnimationBarButton.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/20/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import UIKit

class AnimationBarButton: UIBarButtonItem, Rotatable {
    
    @IBInspectable var normalImageName: String = ""
    @IBInspectable var selectedImageName: String = ""
    @IBInspectable var duration: Double = 1
    
    let normalView = UIImageView(frame: .zero)
    let selectedView = UIImageView(frame: .zero)
}

extension AnimationBarButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        configureImageViews()
    }
}

extension AnimationBarButton {
    func animationSelected(selected: Bool) {
        
        if selected {
            rotateAnimationFrom(normalView, toItem: selectedView, duration: duration)
        } else {
            rotateAnimationFrom(selectedView, toItem: normalView, duration: duration)
        }
    }
}

extension AnimationBarButton {
    
    func configureImageViews() {
        configureImageView(normalView, imageName: normalImageName)
        configureImageView(selectedView, imageName: selectedImageName)
        selectedView.alpha = 0
    }
    
    private func configureImageView(imageView: UIImageView, imageName: String) {
        guard let customView = customView else { return }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: String(imageName))
        imageView.contentMode = .ScaleAspectFit
        customView.addSubview(imageView)
        [(NSLayoutAttribute.CenterX, 12), (.CenterY, -1)].forEach { info in
            (customView, imageView) >>>- {
                $0.attribute = info.0
                $0.constant = CGFloat(info.1)
            }
        }
        [NSLayoutAttribute.Height, .Width].forEach { attribute in
            imageView >>>- {
                $0.attribute = attribute
                $0.constant = 20
            }
        }
    }

}