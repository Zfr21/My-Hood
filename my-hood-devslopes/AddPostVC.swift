//
//  AddPostVC.swift
//  my-hood-devslopes
//
//  Created by Zafer Celaloglu on 27.12.2015.
//  Copyright © 2015 Zafer Celaloglu. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true

    }

    @IBAction func makePostBtnPressed(sender: AnyObject) {
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {

            let imgPath = DataService.instance.saveImageAndCreatePath(img)

            let post = Post(imagePath: imgPath, title: title, description: desc)
            DataService.instance.addPost(post)

            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addPickBtnPressed(sender: UIButton!) {
        sender.setTitle("", forState: .Normal)

        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){

            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            //imagePicker.mediaTypes = [kUTTypeImage]
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        } else if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)){
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
    }
}
