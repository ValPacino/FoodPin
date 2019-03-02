//
//  Restaurant.swift
//  FoodPin
//
//  Created by Öcalan on 02/03/2019.
//  Copyright © 2019 Froidefond Valentin. All rights reserved.
//

import Foundation


class Restaurant {
    
    var name: String
    var type: String
    var location: String
    var image: String
    var isVisited: Bool
    
    init(name: String, type: String, location: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = name
        self.isVisited = isVisited
    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", isVisited: false)
    }
    
}
