//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Öcalan on 25/02/2019.
//  Copyright © 2019 Froidefond Valentin. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend","Homei","Teakha","Cafe Loisl","Petite Oyster","For Kee Restaurant","Po's Atelier","Bourke Street Bakery","Haigh's Chocolate","Palomino Espresso","Upstate","Traif","Graham Avenue Meats And Deli","Waffle & Wolf","Five Leaves","Cafe Lore","Confessional","Barrafina","Donostia","Royal Oak","CASK Pub and Kitchen"]
    
    var restaurantLocations = ["Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Sidney","Sidney","Sidney","New York","New York","New York","New York","New York","New York","New York","London","London","London","London"]
    
    var restaurantTypes = ["Coffe & Tea Shop","Cafe","Tea House","Austrian / Causual Drink","French","Bakery","Chocolate","Cafe","Americain / Seafood","American","American","Breakfast & Brunch","Coffee & Tea","Coffe & Tea","Coffea & Tea","Latin America","Spanish","Spanish","Spanish","British","Thai"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurantNames[indexPath.row] //On assigne comme valeur au text l'élément de notre tableau.
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantNames[indexPath.row]) // On ajoute une image à la cellule
        
        return cell
    }

}
