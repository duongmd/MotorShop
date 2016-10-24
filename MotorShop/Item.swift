//
//  Item.swift
//  MotorShop
//
//  Created by iOS Student on 10/19/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String?
    var content: String?
    var nameImages: [String] = []
    var price: String?
    init(name: String, content: String, nameImages: [String], price: String)
    {
        self.name = name
        self.content = content
        self.nameImages = nameImages
        self.price = price
    }
}
