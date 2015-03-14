//
//  AllEventsViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit

class AllEventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var allEventsCollectionView: UICollectionView?
    var eventsArray = ["event1", "event2", "event3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allEventsCollectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier:"reuseEventCell")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 100)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuseEventCell", forIndexPath: indexPath) as    UICollectionViewCell
        var view: UIView = UIView()
        view.backgroundColor = UIColor.blueColor();
        cell.backgroundView=view
        return cell
        
    }
    
    
    
    
    
    
}