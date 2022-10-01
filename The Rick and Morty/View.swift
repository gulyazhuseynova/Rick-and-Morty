//
//  ViewController.swift
//  The Rick and Morty
//
//  Created by Gulyaz Huseynova on 26.09.22.
//

import UIKit
import SDWebImage


class ViewController: UIViewController {
    
    var apiData : ApiData?
    var manager = Manager()
    var pageCount: Int = 1
    var characters : [Results?] = []
    var bottomDidReached = false
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        setBindings()
        manager.getRequest(pageCount: pageCount)
        
    }
    
    func setBindings() {
        manager.success = {item in
            DispatchQueue.main.async {
                self.apiData = item
                self.characters.append(contentsOf: item?.results ?? [])
                self.collection.reloadData()
            }
        }
        

    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableCell", for: indexPath) as! CollectionViewCell
        if let data = characters[indexPath.row]{
            cell.characterName.text = data.name
            cell.image.sd_setImage(with: data.image, placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.dataReceived = characters[indexPath.row]
        
        present(detailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == characters.count - 1 { //scrolled till reaching to show all 20 elements
            if pageCount < apiData?.info?.pages ?? 0 { //stop when reaching max pages that is provided by API
                bottomDidReached = true
                pageCount += 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 , execute: {
                    self.manager.getRequest(pageCount: self.pageCount)
                    self.bottomDidReached = false
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReusableView", for: indexPath) as! CollectionReusableView
        if bottomDidReached == true {
            view.spinner.startAnimating()
            return view
        }else{
            view.spinner.stopAnimating()
            return view
        }
        
    }
}
