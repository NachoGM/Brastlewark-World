//
//  DetailPlayerVC.swift
//  NGM-AXA-SopraSteria
//
//  Created by Nacho MAC on 7/8/17.
//  Copyright © 2017 Nacho MAC. All rights reserved.
//

import UIKit

class DetailPlayerVC: UIViewController {

    // MARK: Declare Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var namesString: UILabel!
    @IBOutlet weak var nameString: UIView!
    @IBOutlet weak var hairColorString: UILabel!
    @IBOutlet weak var ageString: UILabel!
    @IBOutlet weak var heightString: UILabel!
    @IBOutlet weak var weightString: UILabel!
    @IBOutlet weak var friendsString: UITextView!
    @IBOutlet weak var professionsString: UITextView!
    
    var nameGnome:String!
    var hairColor:String!
    var thumbnail:String!
    var age:Int32!
    var weight:Double!
    var height:Double!
    var friendsGnome:NSArray!
    var professionsGnome:NSArray!
    
    // MARK: Display LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateInfo()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Get info from ViewController
    func updateInfo() {
        self.namesString.text = nameGnome!
        self.hairColorString.text = hairColor!
        self.ageString.text = String(age!)
        self.heightString.text = String(height!)
        self.weightString.text = String(weight!)
        self.professionsString.text = "\(professionsGnome.componentsJoined(by: " , "))"
        self.friendsString.text = "\(friendsGnome.componentsJoined(by: " , "))"

        let imgURL = URL(string:thumbnail)
        let data = NSData(contentsOf: (imgURL)!)
        self.imageView.image = UIImage(data: data! as Data)
    }
    
    
    // MARK: Action Buttons
    @IBAction func backBtn(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
