//
//  View3.swift
//  The Rick and Morty
//
//  Created by Gulyaz Huseynova on 29.09.22.
//

import UIKit

class ViewController3: UIViewController {
    
    var dataReceived : PopUpViewData?
  
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var popUpImage: UIImageView!
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var heading3: UILabel!
    @IBOutlet weak var heading2: UILabel!
    @IBOutlet weak var heading1: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationType: UILabel!
    @IBOutlet weak var locationDimension: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        dismissPopUpView()
    }
    
    
    func setUpView () {
        popUpView.layer.cornerRadius = popUpView.frame.height / 5
        popUpImage.layer.cornerRadius = popUpImage.frame.height / 5
        
        heading1.text = dataReceived?.heading1
        heading2.text = dataReceived?.heading2
        heading3.text = dataReceived?.heading3
        
        locationName.text = dataReceived?.body1
        locationType.text = dataReceived?.body2
        locationDimension.text = dataReceived?.body3
        
        heading1.textColor = UIColor(named: dataReceived?.headingColor ?? "")
        heading2.textColor = UIColor(named: dataReceived?.headingColor ?? "")
        heading3.textColor = UIColor(named: dataReceived?.headingColor ?? "")
        
        locationName.textColor = UIColor(named: dataReceived?.bodyColor ?? "")
        locationType.textColor = UIColor(named: dataReceived?.bodyColor ?? "")
        locationDimension.textColor = UIColor(named: dataReceived?.bodyColor ?? "")
        
        popUpImage.image = UIImage(named: dataReceived?.imageName ?? "")

   }
    
    func dismissPopUpView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController3.tapFunction))
                backView.isUserInteractionEnabled = true
                backView.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        }
    //UIImageView(image: UIImage(named: dataReceived?.imageName ?? ""))
    
    
}




