//
//  ViewController.swift
//  NGM-AXA-SopraSteria
//
//  Created by Nacho MAC on 7/8/17.
//  Copyright © 2017 Nacho MAC. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var nameArray = [String]()
    
    var thumbnailArray = [String]()
    
    var ageArray = [Int32]()
    
    var hairColorArray = [String]()
    
    var heightArray = [Int32]()
    
    var weightArray = [Int32]()
    
    var friendsArray = [NSArray]()
    
    var professionsArray = [NSArray]()

    
    // MARKS: Modify Status Bar Color
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    
    // MARKS: Download & parse JSON
    
    func downloadJson() {
        
        var request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json")!)

        request.httpMethod = "GET"
        
        SVProgressHUD.show(withStatus: "Loading data...")

        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if let dataObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                let dataArraySuper = dataObj?["Brastlewark"]
                print("JSON Response = \(dataArraySuper!)")
                SVProgressHUD.dismiss()


                if let gnomeArray =  dataObj!.value(forKey: "Brastlewark") as? NSArray {
                    
                    for gnomes in gnomeArray{
                        
                        if let gnomesDict = gnomes as? NSDictionary {
                            if let name = gnomesDict.value(forKey: "name") {
                                self.nameArray.append(name as! String)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "thumbnail") {
                                self.thumbnailArray.append(name as! String)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "age") {
                                self.ageArray.append(name as! Int32)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "hair_color") {
                                self.hairColorArray.append(name as! String)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "height") {
                                self.heightArray.append(name as! Int32)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "weight") {
                                self.weightArray.append(name as! Int32)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "friends") {
                                self.friendsArray.append(name as! NSArray)
                                
                            }
                            
                            if let name = gnomesDict.value(forKey: "professions") {
                                self.professionsArray.append(name as! NSArray)
                                
                            }
                        }
                    }
                }

                OperationQueue.main.addOperation({
                    self.collectionView.reloadData()
                })
            }

        }).resume()

    }
    
    
    // MARKS: CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return thumbnailArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let imgURL = NSURL(string: thumbnailArray[indexPath.row])
        
        if imgURL != nil {
            
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.gnomeNames.text = nameArray[indexPath.row]
            cell.gnomeThumbnail.image = UIImage(data: data! as Data)
            
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2 - 1
        
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailPlayer = self.storyboard?.instantiateViewController(withIdentifier: "DetailPlayerVC") as! DetailPlayerVC
        
        detailPlayer.nameGnome = nameArray[indexPath.row]
        detailPlayer.weight = weightArray[indexPath.row]
        detailPlayer.height = heightArray[indexPath.row]
        detailPlayer.age = ageArray[indexPath.row]
        detailPlayer.thumbnail = thumbnailArray[indexPath.row]
        detailPlayer.hairColor = hairColorArray[indexPath.row]
        detailPlayer.friendsGnome = friendsArray[indexPath.row]
        detailPlayer.professionsGnome = professionsArray[indexPath.row]
        
        self.navigationController?.pushViewController(detailPlayer, animated: true)
        
    }
    
    
}



