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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurantImageName = restaurantNames[indexPath.row]
                destinationController.restaurantName_ = restaurantNames[indexPath.row]
                destinationController.restaurantLocation_ = restaurantLocations[indexPath.row]
                destinationController.restaurantType_ = restaurantTypes[indexPath.row]
            }
        }
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
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    // si l'utilisateur swipe vers la gauche, des boutons s'affichent sur la droite de la cellule
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Un bouton delete s'affiche sur la droite, il fera les actions demandés
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action,sourceView,completionHandler) in
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            //Masqué le handler par la suite
            completionHandler(true)
        }
        
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action,sourceView,completionHandler) in
            let defaultText = "Just checking at " + self.restaurantNames[indexPath.row]
            
            //Un UIActivityController permet d'afficher un menu pour paratager le contenu souhaité
            let activityController : UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurantNames[indexPath.row]) {
                activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            //Layout iPad
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        //On ajoute les SwipeActions dans un SwipeConfiguration que l'on retourne
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkAction = UIContextualAction(style: .normal, title: "check") { (action,sourceView,completionHandler) in
            let cell = tableView.cellForRow(at: indexPath)
            
            if self.restaurantIsVisited[indexPath.row] == false {
                cell?.accessoryView = UIImageView(image: UIImage(named: "heart-tick"))
                self.restaurantIsVisited[indexPath.row] = true
            } else {
                cell?.accessoryView = .none
                self.restaurantIsVisited[indexPath.row] = false
            }
            
            completionHandler(true)
        }
        
        checkAction.backgroundColor = .green
        if self.restaurantIsVisited[indexPath.row] == false {
            checkAction.image = UIImage(named: "tick")
        } else {
            checkAction.image = UIImage(named: "undo")
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        
        return swipeConfiguration
    }

}
