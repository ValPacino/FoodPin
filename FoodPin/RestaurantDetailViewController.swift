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
    
    var restaurantImageName = ""
    var restaurantName_ = ""
    var restaurantType_ = ""
    var restaurantLocation_ = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.largeTitleDisplayMode = .never
        restaurantImageView.image = UIImage(named: restaurantImageName)
        restaurantName.text = restaurantName_
        restaurantType.text = restaurantType_
        restaurantLocation.text = restaurantLocation_
    }
    
    
}
