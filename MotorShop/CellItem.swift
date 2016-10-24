//
//  CellItem.swift
//  MotorShop
//
//  Created by iOS Student on 10/20/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit

class CellItem: UICollectionViewCell {
    var nameLabel: UILabel!
    var imageView: UIImageView!
    var price: UILabel!
    var priceLabelHeight: CGFloat = 30
    var cellWidth: CGFloat = 250
    var labelHeight: CGFloat = 40
    var imageHeight: CGFloat = 300
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSubview() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: imageHeight))
            imageView.layer.borderColor = tintColor.cgColor
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
        }
        if (nameLabel == nil) {
            nameLabel = UILabel(frame: CGRect(x: 0, y: imageHeight, width: cellWidth, height: labelHeight))
            nameLabel.textAlignment = .left
            nameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            nameLabel.highlightedTextColor = tintColor
            nameLabel.font = UIFont.systemFont(ofSize: 20)
            nameLabel.numberOfLines = 2 //default = 1
            contentView.addSubview(nameLabel)
        }
        if (price == nil) {
            price = UILabel(frame: CGRect(x: 0, y: imageHeight + labelHeight, width: cellWidth, height: priceLabelHeight))
            price.textAlignment = .left
            price.textColor = UIColor(red: 255/255, green: 165/255, blue: 65/255, alpha: 1)
            price.font = UIFont.boldSystemFont(ofSize: 15)
            contentView.addSubview(price)
        }
        
    }
    
    //Xet border cho anh khi select, default = 0
    override var isSelected: Bool {
        didSet {
            imageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
}
