//
//  NewRestaurantTableViewController.swift
//  FoodPin
//
//  Created by Öcalan on 10/03/2019.
//  Copyright © 2019 Froidefond Valentin. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            //nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var adressTextField: RoundedTextField! {
        didSet {
            adressTextField.tag = 3
            adressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 5.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont ]
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibrary)
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let _ = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        
        let _ = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        
        let _ = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        
        let _ = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        if nameTextField.text?.count == 0 || typeTextField.text?.count == 0 || adressTextField.text?.count == 0 || phoneTextField.text?.count == 0 || descriptionTextView.text?.count == 0 {
            let errorMessage = "We can't prompted because one of the all fields is blank. Please note that all fields are required."
        
            let alertController = UIAlertController(title: "Oops", message: errorMessage, preferredStyle: .alert)
        
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
            alertController.addAction(cancelAction)
        
        
            present(alertController, animated: true, completion: nil)
            
            
        } else {
            guard let name = nameTextField.text else {
                print("Error...")
                return
            }
            print("Name: \(name)")
            
            guard let type = typeTextField.text else {
                print("Error...")
                return
            }
            print("Type: \(type)")
            
            guard let location = adressTextField.text else {
                print("Error...")
                return
            }
            print("Name: \(location)")
            
            guard let phone = phoneTextField.text else {
                print("Error...")
                return
            }
            print("Name: \(phone)")
            
            guard let description = descriptionTextView.text else {
                print("Error...")
                return
            }
            print("Name: \(description)")
            
            dismiss(animated: true, completion: nil)
        }
    }
    
}
