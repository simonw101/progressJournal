//
//  CreateProgressUpdateViewController.swift
//  Progress Journal
//
//  Created by Simon Wilson on 08/12/2020.
//

import UIKit

class CreateProgressUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = addButton.frame.size.height / 2

        pickerController.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            
            photoImageView.image = selectedImage
            
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func existingPhotoTapped(_ sender: Any) {
        
        pickerController.sourceType = .photoLibrary
        
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let progressUpdateToBeSaved = ProgressUpdate(context: context)
            
            progressUpdateToBeSaved.title = titleTextField.text
            
            progressUpdateToBeSaved.image = photoImageView.image?.jpegData(compressionQuality: 1.0)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
        }
        
        navigationController?.popViewController(animated: true)
        
    }
}
