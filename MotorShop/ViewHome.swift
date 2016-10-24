//
//  ViewHome.swift
//  MotorShop
//
//  Created by iOS Student on 10/19/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit

class ViewHome: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var items: [Item] = []
    
    override func viewDidLoad() {
        var myDict: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "items", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }

        for dic in (myDict!.allValues as? [[String: Any]])!
        {
            self.items.append(Item(name: dic["name"] as! String, content: dic["content"] as! String, nameImages: dic["images"] as! NSArray as! [String], price: dic["price"] as! String))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellItem
        cell.addSubview()
        
        cell.imageView.image = UIImage(named: items[indexPath.item].nameImages[0] + ".jpg")
        cell.nameLabel.text = items[indexPath.item].name
        cell.price.text = items[indexPath.item].price
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let scrollView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as? ViewScroll
        
        scrollView?.pageImages = items[(indexPath as NSIndexPath).item].nameImages
    
        self.navigationController?.pushViewController(scrollView!, animated: true)
    }
}
