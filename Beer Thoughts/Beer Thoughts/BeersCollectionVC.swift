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
    static var imageCache = NSCache()
    private var beerNamesArray = ["ale-to-the-chief", "baby-trogdor-the-burninator", "baltic-porter", "barrel-aged-series", "bourbon-barrel-aged-carlos-caliente", "chai-brown", "cloud-9", "collaboration-not-litigation-ale", "daywalker", "double-dry-hopped-maharaja", "dugana", "el-gose", "ellie-s-brown-ale", "eremita-ix", "first-lady-of-song", "get-to-the-choppa-schwarzbier", "goat-candy", "gored", "hog-heaven", "dry-hopped-ipa", "ipa", "joe-s-pils", "karma-sutra", "liliko-i-kepolo", "mayan-goddess", "mephistopheles", "mondo-roboticus", "new-world-india-black-ale", "old-jubiliation-ale", "out-of-bounds-stout", "perzik-saison", "pump-ky-n", "quivering-lip", "radlerado-winter-edition", "raja", "raspberry-sour", "rocky-mountain-olson-s", "rumpkin", "salvation", "samael-s", "smash-comet", "smash-galaxy", "stoutwork-orange", "summer-s-day-ipa", "the-beast", "the-czar", "the-kaiser", "the-maharaja", "the-reverend", "tweak", "twenty-three-anniversary", "uncle-jacob-s-stout", "vanilla-bean-stout", "white-rascal", "winter-s-day-ipa"]
    private var realBeers = [Beer]()
}

extension BeersCollectionVC {
    
    override func viewDidLoad() {
        
        getDataFromServer()
        itemSize = CGSize(width: 256, height: 335)
        super.viewDidLoad()
        registerCell()
        fillCellIsOpeenArry()
        addGestureToView(collectionView!)
        //configureNavBar()
    
    }
    
    func getDataFromServer() {
        
//        var beersArray = idArray
//        
//        if let id = beersArray.popLast() {
//            let newBeer = Beer(id: id)
//            newBeer.downloadBeerData({
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.registerCell()
//                    self.collectionView?.reloadData()
//                    //self.fillCellIsOpeenArry()
//                })
//                self.fillCellIsOpeenArry()
//                self.realBeers.append(newBeer)
//            })
//        }
        
        for id in beerNamesArray {
            
            let newBeer = Beer(id: id)
            newBeer.downloadBeerData({
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.collectionView?.reloadData()
                    self.registerCell()
                    //self.fillCellIsOpeenArry()
                })
                self.fillCellIsOpeenArry()
                self.realBeers.append(newBeer)
            })
        }
    }
}


extension BeersCollectionVC {
    
    private func registerCell() {
        let nib = UINib(nibName: String(BeerCell), bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: String(BeerCell))
    }
    
    private func fillCellIsOpeenArry() {
        for _ in realBeers {
            cellsIsOpen.append(false)
        }
    }
    
    private func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: StoriesTableVC = storyboard.instantiateViewController()
        return toViewController
    }
    
//    private func configureNavBar() {
//        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//    }
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
            pushToViewController(getViewController())
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
        
        if realBeers.count > 0 {
            let index = indexPath.row % realBeers.count
            cell.cellIsOpen(cellsIsOpen[index], animated: false)
        }
        
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
        return realBeers.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let beer = realBeers[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(BeerCell), forIndexPath: indexPath) as? BeerCell {
            cell.request?.cancel()
            var image: UIImage?
            if let url = beer.beerImage {
                image = BeersCollectionVC.imageCache.objectForKey(url) as? UIImage
            }
            
            cell.configureCell(beer, img: image)
            return cell
        } else {
            return BeerCell()
        }
    }
}