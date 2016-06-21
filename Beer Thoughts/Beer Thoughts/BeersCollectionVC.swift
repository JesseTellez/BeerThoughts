//
//  BeersCollectionVC.swift
//  Beer Thoughts
//
//  Created by Jesse Tellez on 6/10/16.
//  Copyright © 2016 HomeBrew. All rights reserved.
//

import Foundation
import Alamofire

class BeersCollectionVC: ExpandingViewController {
    
    private var cellsIsOpen = [Bool]()
    private var beerArray: NSArray = NSArray()
    private var beerDictionary: NSDictionary!
    private var beersId = [String]()
    private var otherDictionary: NSDictionary!
}

extension BeersCollectionVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSize = CGSize(width: 256, height: 335)
        
        DataService.ds.downloadAllBeerData { (beers) in
            
            self.beerArray = beers
            dispatch_async(dispatch_get_main_queue(), {
                self.registerCell()
                self.collectionView?.reloadData()
            })
            self.fillCellIsOpeenArry()
            self.makeBeersIdArray()
        }
        
        registerCell()
        fillCellIsOpeenArry()
        addGestureToView(collectionView!)
        configureNavBar()
    
    }
    
    func makeBeersIdArray() {
        
        for i in 0 ..< beerArray.count {
            otherDictionary = beerArray.objectAtIndex(i) as! NSDictionary
            let name = otherDictionary["id"] as? String
            beersId.append(name!)
        }
        
//        for i in beerArray {
//            otherDictionary = beerArray.objectAtIndex(i as! Int) as! NSDictionary
//            let name = otherDictionary["id"] as? String
//            beersId.append(name!)
//        }
    }
}


extension BeersCollectionVC {
    
    private func registerCell() {
        let nib = UINib(nibName: String(BeerCell), bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: String(BeerCell))
    }
    
    private func fillCellIsOpeenArry() {
        for _ in beerArray {
            cellsIsOpen.append(false)
        }
    }
    
    private func getViewController(index: Int) -> ExpandingTableViewController {
        
        //how am I going to pass an object doing this?
        
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: StoriesTableVC = storyboard.instantiateViewController()
        toViewController.beer = beersId[index]
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
        if cell.isOpened == true && sender.direction == .Up {
            pushToViewController(getViewController(indexPath.row))
        }
        
        let open = sender.direction == .Up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }
}

extension BeersCollectionVC {
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        super.collectionView(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
        guard let cell = cell as? BeerCell else { return }
        
//        if beerArray.count < cellsIsOpen.count {
//            
//        }
        let index = indexPath.row % beerArray.count
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? BeerCell
            where currentIndex == indexPath.row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
            //may need to change code below
            cell.arrowImage.hidden = true
        } else {
            cell.arrowImage.hidden = true
            
            print("THIS IS THE BEER TO BE PASSED: \(beersId[indexPath.row])")
            
            pushToViewController(getViewController(indexPath.row))
            if let rightButton = navigationItem.rightBarButtonItem as? AnimationBarButton {
                rightButton.animationSelected(true)
            }
        }
    }
}


extension BeersCollectionVC {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(BeerCell), forIndexPath: indexPath) as? BeerCell {
            beerDictionary = self.beerArray.objectAtIndex(indexPath.row) as! NSDictionary
            let newBeer = Beer(withDictionary: beerDictionary)
            cell.configureCell(newBeer)
            
            return cell
        } else {
            return BeerCell()
        }
    }
}