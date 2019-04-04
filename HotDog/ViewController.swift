//
//  ViewController.swift
//  HotDog
//
//  Created by Benjamin on 2019-04-04.
//  Copyright © 2019 se.Benjamin.Aronsson. All rights reserved.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker =  UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.allowsEditing = false
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true)
    }

}

extension ViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        imageView.image = userPickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController : UINavigationControllerDelegate {
    
}

