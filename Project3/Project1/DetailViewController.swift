//
//  DetailViewController.swift
//  Project1
//
//  Created by julie on 21/02/2019.
//  Copyright © 2019 booksgit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // This is the fonction that will make us able to shqre the images
    // @ogjc because this function will be transcribed in obj c
    // zhich is needed be one of the classes in the following line
    //         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    // We also need to update info.plist so that we actually have the permission from the user to share some stuff
    // for exanple add the pictures to the picture library of the user
    
    // @IBAction automatically implies @objc
    @objc func shareTapped()
    {
        // 1.0 == max quality
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
       // let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        let thisImage = [selectedImage, "bad code"]
        let vc = UIActivityViewController(activityItems: [thisImage[0] as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
