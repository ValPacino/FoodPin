//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Öcalan on 28/02/2019.
//  Copyright © 2019 Froidefond Valentin. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantName: UILabel!
    @IBOutlet var restaurantType: UILabel!
    @IBOutlet var restaurantLocation: UILabel!
    
    var restaurant: Restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.largeTitleDisplayMode = .never
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantName.text = restaurant.name
        restaurantType.text = restaurant.type
        restaurantLocation.text = restaurant.location
    }
}
