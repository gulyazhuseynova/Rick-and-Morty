//
//  ViewController2.swift
//  The Rick and Morty
//
//  Created by Gulyaz Huseynova on 26.09.22.
//

import UIKit

class ViewController2: UIViewController {
    var manager = Manager()
    var dataReceived : Results?
    var checkStatus : String?
    var locationData : ApiDataLocation?
    var episodeData : ApiDataEpisode?
    
    
    @IBOutlet weak var lastKnownLocation: UILabel!
    @IBOutlet weak var lastKnownLocationButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var statusColor: UIView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var firstSeenIn: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBindings()
        setUpView()
        
        manager.getEpisodeRequest(url: dataReceived?.episode[0] ?? "")
        manager.getLocationRequest(url: dataReceived?.location?.url ?? "")
        
        lastKnownLocationTapGesture()
        firstSeenInEpisodeTapGesture()
       
    }
    
    func lastKnownLocationTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController2.tapFunction1))
        lastKnownLocation.isUserInteractionEnabled = true
        lastKnownLocation.addGestureRecognizer(tap)
    }
    
    func firstSeenInEpisodeTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController2.tapFunction2))
        firstSeenIn.isUserInteractionEnabled = true
        firstSeenIn.addGestureRecognizer(tap)
    }
    
    
    func setUpView (){
        statusColor.layer.cornerRadius = statusColor.frame.height / 2
        backButton.layer.cornerRadius = backButton.frame.height / 2
        characterImage.layer.cornerRadius = characterImage.frame.height / 5
        characterImage.layer.borderWidth = 0.5
        
        characterName.text = dataReceived?.name
        checkStatus = dataReceived?.status
        
        if checkStatus == "Alive" {
            statusColor.backgroundColor = .systemGreen
        }
        if checkStatus == "Dead" {
            statusColor.backgroundColor = .systemRed
        }
        if checkStatus == "unknown" {
            statusColor.backgroundColor = .systemGray
        }
        
        statusLabel.text = "\(dataReceived?.status ?? "") - \(dataReceived?.species ?? "")"
        lastKnownLocation.text = dataReceived?.location?.name
   
        characterImage.sd_setImage(with: dataReceived?.image, placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    
    func setBindings () {
        manager.success2 = {item in
            DispatchQueue.main.async {
                self.episodeData = item
                self.firstSeenIn.text = item?.name
            }
        }
        manager.success3 = {item in
            DispatchQueue.main.async {
                self.locationData = item

            }
        }
    }
    
    @objc func tapFunction1(sender:UITapGestureRecognizer) {
        
        let data = PopUpViewData(imageName: "background2", heading1: "Name of Location", body1: locationData?.name ?? "", heading2: "Type of location", body2: locationData?.type ?? "", heading3: "Dimension", body3: locationData?.dimension ?? "", headingColor: "locationHeading", bodyColor: "locationBody")

        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.dataReceived = data
        
        present(detailVC, animated: true, completion: nil)
    }
    
    @objc func tapFunction2(sender:UITapGestureRecognizer) {

        let data = PopUpViewData(imageName: "background3", heading1: "Episode name", body1: episodeData?.name ?? "", heading2: "Episode air date", body2: episodeData?.air_date ?? "", heading3: "Episode number", body3: numberToNameConverter(episodeData?.episode ?? ""), headingColor:  "episodeHeading", bodyColor: "episodeBody")
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.dataReceived = data
        
        present(detailVC, animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func numberToNameConverter (_ str: String) -> String { //S01E01
        
        if str[1] == "0" && str [4] != "0" {
            return "Season \(str[2]), Episode \(str[4 ..< 6])"
        }
        if str[1] != "0" && str [4] == "0" {
            return "Season \(str[1 ..< 3]), Episode \(str[5])"
        }
        if str[1] == "0" && str [4] == "0" {
            return "Season \(str[2]), Episode \(str[5])"
        }
        else{
            return "Season \(str[1 ..< 3]), Episode \(str[4 ..< 6])"
        }
    }
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
