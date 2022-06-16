//
//  CustomCollectionViewCell.swift
//  Makeup
//
//  Created by Даниил Махно on 24.05.2022.
//

import UIKit
import SDWebImage

class CustomCollectionViewCell: UICollectionViewCell {

//
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
    func configureCell(item: Product) {
        let url = URL(string: item.imagePath!)
        productImage.sd_setImage(with: url, placeholderImage: UIImage.init(named: "NoPhotoAvailable"))
        nameLabel.text = item.name
        let price = (item.priceSign ?? "$") + " " + (item.price ?? "No price available")
        priceLabel.text = price
        categoryLabel.text = item.category  ?? "No catergory"
        categoryLabel.textColor = .gray
        ratingLabel.text = convertToString(rating: item.rating)
       
    }
    
    func convertToString(rating: Double?) -> String {
        if rating == nil {
            return "★ 0.0"
        } else {
            return "★ " + String(format: "%.*f", rating!) + ".0"
        }
    }
}

