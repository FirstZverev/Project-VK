//
//  CollectionViewLayout.swift
//  WeatherApp
//
//  Created by Володя Зверев on 12.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit



class CollectionViewLayout: UICollectionViewLayout {
    
    var cacheAttributes: [IndexPath : UICollectionViewLayoutAttributes] = [:]
    
    var cellHeight: CGFloat = 128
    
    var totalHeight: CGFloat = 0
    
    override func prepare() {
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        if itemsCount <= 0 {
            return
        }
        
        let fullWidth  = collectionView.frame.size.width
        let smallWidth = collectionView.frame.size.width / 2
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for i in 0..<itemsCount {
            let indexPath = IndexPath(row: i, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            if i % 3 == 0 {
                attributes.frame = CGRect(x: x, y: y, width: fullWidth, height: cellHeight)
                x = 0
                y += cellHeight
            } else if i % 3 == 1 {
                attributes.frame = CGRect(x: x, y: y, width: smallWidth, height: cellHeight)
                x += smallWidth
            }  else if i % 3 == 2 {
                attributes.frame = CGRect(x: x, y: y, width: smallWidth, height: cellHeight)
                x = 0
                y += cellHeight
            }
            
            print("attributes.frame \(attributes.frame)")
            
            self.totalHeight = y
            
            self.cacheAttributes[indexPath] = attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cacheAttributes.values.filter({ (attributes: UICollectionViewLayoutAttributes) -> Bool in
            return rect.intersects(attributes.frame)
        })
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.size.width ?? 0, height: self.totalHeight)
    }
}

