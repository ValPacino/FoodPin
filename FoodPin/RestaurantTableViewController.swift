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
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true //Cette méthode permet d'adapter le layout (cell width) pour iPad
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
        
        if restaurantIsVisited[indexPath.row] == true {
            cell.accessoryView = UIImageView(image: UIImage(named: "heart-tick"))
        } else {
            cell.accessoryView = .none
        }
        
        return cell
    }
    
    //Cette méthode est appelé à chaque fois que l'on touche une cellule de la UITableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //On déclare un UIAlertController qui s'affichera lors de l'interaction avec la cellule
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do ?", preferredStyle: .actionSheet)
        
        //On déclare une action (en lien avec le UIAlertController)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //On ajoute l'action à notre UIAlertController
        optionMenu.addAction(cancelAction)
        
        //Voici comment faire un callActionHandler
        let callActionHandler = { (action: UIAlertAction) -> Void in
            //Comme en haut, on créer une action  qu'on ajoutera à notre UIAlerteController
            let alertMessage = UIAlertController(title: "Service Unvailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            //Pour afficher l'UIAlertcontroller
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        //Dans cette UIAlerteAction, on rajoute le callActionHandler écrit plus haut, il sera affiché lors de l'interaction avec cette action là
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        
        optionMenu.addAction(callAction)
        
        //Voici comment gérer les actions avec les cellules via le système d'"alerte"
        let checkInAction = UIAlertAction(title: "Heart it", style: .default, handler: {(action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            
            if self.restaurantIsVisited[indexPath.row] == false {
                cell?.accessoryView = UIImageView(image: UIImage(named: "heart-tick"))
                self.restaurantIsVisited[indexPath.row] = true
            } else {
                cell?.accessoryView = .none
                self.restaurantIsVisited[indexPath.row] = false
            }
        })
        
        optionMenu.addAction(checkInAction)
        present(optionMenu, animated: true, completion: nil)
        
        //Ne pas afficher le gris quand on intéragit avec la cellule
        tableView.deselectRow(at: indexPath, animated: false)
        
        //Layout iPad
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
    }

}
