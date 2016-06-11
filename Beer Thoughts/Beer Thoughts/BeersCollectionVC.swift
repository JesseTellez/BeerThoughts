//
//  BeersCollectionVC.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import expanding_collection

class BeersCollectionVC: ExpandingViewController {
    
    private var cellsIsOpen = [Bool]()
    private let beers = [Beer]()
}

extension BeersCollectionVC {
    
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 335)
        super.viewDidLoad()
        registerCell()
        fillCellIsOpeenArry()
        addGestureToView(collectionView!)
        configureNavBar()
    }
}


extension BeersCollectionVC {
    
    private func registerCell() {
        let nib = UINib(nibName: String(BeerCell), bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: String(BeerCell))
    }
    
    private func fillCellIsOpeenArry() {
        for _ in beers {
            cellsIsOpen.append(false)
        }
    }
    
    private func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: StoriesTableVC = storyboard.instantiateViewController()
        return toViewController
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}

extension BeersCollectionVC {
    
    private func addGestureToView(toView: UIView) {
        let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(BeersCollectionVC.swipeHandler(_:)))) {
            $0.direction = .Up
        }
        
        let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(BeersCollectionVC.swipeHandler(_:)))) {
            $0.direction = .Down
        }
        toView.addGestureRecognizer(gesutereUp)
        toView.addGestureRecognizer(gesutereDown)
    }
    
    func swipeHandler(sender: UISwipeGestureRecognizer) {
        let indexPath = NSIndexPath(forRow: currentIndex, inSection: 0)
        guard let cell  = collectionView?.cellForItemAtIndexPath(indexPath) as? BeerCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .Up {
            pushToViewController(getViewController())
        }
        
        let open = sender.direction == .Up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }
}

extension BeersCollectionVC {
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? BeerCell else {
            return
        }
        let index = indexPath.row % beers.count
        
        cell.backgrondImageView.image = UIImage(named: "Something")
        cell.titleLabel.text = "Something"
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? BeerCell
            where currentIndex == indexPath.row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())
        }
    }
}


extension BeersCollectionVC {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(BeerCell), forIndexPath: indexPath) as! BeerCell
        cell.configureCell(beers[indexPath.row])
        return cell
    }
}