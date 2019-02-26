//
//  ViewController.swift
//  Project1
//
//  Created by julie on 20/02/2019.
//  Copyright © 2019 booksgit. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var picturesNotSorted = [String]()
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewerr"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is the name of a picture to load!
                picturesNotSorted.append(item)
            }
        }
        print("pictures not sorted")
        print(picturesNotSorted)
        pictures = picturesNotSorted.sorted()
        print("pictures sorted")
        /*
         Sort not working
         I feel like I am not incrementing ar the right time
         but I am moving on
         
        print("pictures sorted")
        var i = 0
        var j = 0
        var tmpHolder: String
        let indexMax = picturesNotSorted.count
        while i < indexMax
        {
            while j < indexMax
            {
                j = i + 1
                if picturesNotSorted[i] > picturesNotSorted[j]
                {
                    tmpHolder = picturesNotSorted[i]
                    picturesNotSorted[i] = picturesNotSorted[j]
                    picturesNotSorted[j] = tmpHolder
                    j += 1
                }
            }
            i += 1
            print(i)
           }
         */
        print(pictures)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        //cell.textLabel?.text = pictures[indexPath.row]
        cell.textLabel?.text = " Picture \(indexPath.row + 1) of \(pictures.count)"
        // YES
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

