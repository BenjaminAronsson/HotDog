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
    
    func detect(image : CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {fatalError("Loading coreML model failed")}
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {fatalError("Model failed to process image")}
            
            //proeccessed image
            if let firstResult = result.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "Hotdog!"
                } else {
                    self.navigationItem.title = "Not hotdog!"
                }
            }
            
            
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
        try handler.perform([request])
        }
        catch {
            print(error)
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true)
    }

}

extension ViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            //coreml stuff
            guard let ciimage = CIImage(image: userPickedImage) else {fatalError("Could not convert to ciimage")}
            
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController : UINavigationControllerDelegate {
    
}

