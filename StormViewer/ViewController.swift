//
//  ViewController.swift
//  StormViewer
//
//  Created by Vincent Palma on 2022-08-14.
//

import UIKit

//What shows on the screen , this is the main class
class ViewController: UITableViewController { // view controller inherits from UITableViewController for the functions we need
    var pictures = [String]()

    // ovverride the white screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.isTranslucent = true
        // this is used to look for files
        let fm = FileManager.default
        // set the path for where the assets are, ! can be dangerous but this one has resource path
        let path = Bundle.main.resourcePath!
        // create the items from the path we gave, ! can be dangerous
        // if try fails the app will crash
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // all this will get destroyed when viewDidLoad runs
        
        for item in items {
            // load the pics with the filename containing nssl
            if item.hasPrefix("nssl"){
                // append the pictures to the array
                pictures.append(item)
            }
            print(pictures)
        }
        
        
    }
    
    // change the behaviour of the main funciton
    // how many rows should be shown
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath/*Contains section number and row number*/) -> UITableViewCell {
        
        // when a cell gets out of view it gets recycled in the bottom when scrolling
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        // give the cell a text? for each image according to its index
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? /*potential to fail thats why we use if let*/DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}

