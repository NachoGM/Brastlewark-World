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
    
    var player = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson()
        initCollectionViewMethods()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initCollectionViewMethods() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Download & parse JSON
    func downloadJson() {
        let url = URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        SVProgressHUD.show(withStatus: "Loading data")

        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            if let dataObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let gnomeArray =  dataObj!.value(forKey: "Brastlewark") as? NSArray {
                    for gnomes in gnomeArray{
                        if let gnomesDict = gnomes as? NSDictionary {
                            let name = gnomesDict.value(forKey: "name") as? String ?? ""
                            let thumbnail = gnomesDict.value(forKey: "thumbnail") as? String ?? ""
                            let age = gnomesDict.value(forKey: "age") as? Int32 ?? 0
                            let hairColor = gnomesDict.value(forKey: "hair_color") as? String ?? ""
                            let height = gnomesDict.value(forKey: "height") as? Double
                            let weight = gnomesDict.value(forKey: "weight") as? Double
                            let friends = gnomesDict.value(forKey: "friends") as? NSArray ?? []
                            let professions = gnomesDict.value(forKey: "professions") as? NSArray ?? []
                            
                            let playerObject = Player(name: name, thumbnail: thumbnail, age: age, hairColor: hairColor, height: height!, weight: weight!, friends: friends, professions: professions)
                            self.player.append(playerObject)
                        }
                    }
                }

                SVProgressHUD.dismiss()
                
                OperationQueue.main.addOperation({
                    self.collectionView.reloadData()
                })
            } else {
                self.displayAlertMessage(userTitle: "No hemos podido acceder a los datos", userMessage: "Asegúrese de estar conectado al Wi-Fi más cercano")
                return
            }

        }).resume()

    }
    
    // MARK: - CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let name = player[indexPath.row].name ?? "Name not found"
        let thumbnail = player[indexPath.row].thumbnail ?? "Thumbnail not found"
        return handleCell(indexPath: indexPath, name: name, thumbnail: thumbnail)
    }
    
    func handleCell(indexPath: IndexPath, name: String, thumbnail: String) -> CollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let imgURL = NSURL(string: thumbnail)
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.gnomeNames.text = name
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
        let player = self.player[indexPath.row]
        let detailPlayer = self.storyboard?.instantiateViewController(withIdentifier: "DetailPlayerVC") as! DetailPlayerVC
        detailPlayer.nameGnome = player.name
        detailPlayer.weight = player.weight
        detailPlayer.height = player.height
        detailPlayer.age = player.age
        detailPlayer.thumbnail = player.thumbnail
        detailPlayer.hairColor = player.hairColor
        detailPlayer.friendsGnome = player.friends
        detailPlayer.professionsGnome = player.professions
        self.navigationController?.pushViewController(detailPlayer, animated: true)
    }
    
}

extension UIViewController {
    func displayAlertMessage(userTitle: String, userMessage: String) {
        
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            return
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
    }
}
