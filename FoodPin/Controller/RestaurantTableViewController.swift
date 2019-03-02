//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Öcalan on 25/02/2019.
//  Copyright © 2019 Froidefond Valentin. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffe & Tea Shop", location: "Honk Kong", isVisited: false),
        Restaurant(name: "Teakha", type: "Cafe", location: "Honk Kong", isVisited: false),
        Restaurant(name: "Cafe Loisl", type: "Tea House", location: "Honk Kong", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "Austrian / Causual Drink", location: "Honk Kong", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "French", location: "Honk Kong", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Chocolate", location: "Honk Kong", isVisited: false),
        Restaurant(name: "Bourke Street Bakery", type: "Cafe", location: "Sidney", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Americain / Seafood", location: "Sidney", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American", location: "Sidney", isVisited: false),
        Restaurant(name: "Upstate", type: "Breakfast & Brunch", location: "New York", isVisited: false),
        Restaurant(name: "Traif", type: "Coffee & Tea", location: "New York", isVisited: false),
        Restaurant(name: "Graham Avenue Meats And Deli", type: "Coffee & Tea", location: "New York", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin America", location: "New York", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", isVisited: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true //Cette méthode permet d'adapter le layout (cell width) pour iPad
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurants[indexPath.row].name //On assigne comme valeur au text l'élément de notre tableau.
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image) // On ajoute une image à la cellule
        
        if restaurants[indexPath.row].isVisited == true {
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
            self.restaurants.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            //Masqué le handler par la suite
            completionHandler(true)
        }
        
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action,sourceView,completionHandler) in
            let defaultText = "Just checking at " + self.restaurants[indexPath.row].name
            
            //Un UIActivityController permet d'afficher un menu pour paratager le contenu souhaité
            let activityController : UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurants[indexPath.row].name) {
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
            
            if self.restaurants[indexPath.row].isVisited == false {
                cell?.accessoryView = UIImageView(image: UIImage(named: "heart-tick"))
                self.restaurants[indexPath.row].isVisited = true
            } else {
                cell?.accessoryView = .none
                self.restaurants[indexPath.row].isVisited = false
            }
            
            completionHandler(true)
        }
        
        checkAction.backgroundColor = .green
        if self.restaurants[indexPath.row].isVisited == false {
            checkAction.image = UIImage(named: "tick")
        } else {
            checkAction.image = UIImage(named: "undo")
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        
        return swipeConfiguration
    }

}
