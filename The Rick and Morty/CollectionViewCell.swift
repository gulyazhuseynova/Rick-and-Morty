//
//  CollectionViewCell.swift
//  The Rick and Morty
//
//  Created by Gulyaz Huseynova on 26.09.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = image.frame.height / 5
        image.layer.borderWidth = 0.5
     
    }
    
}
