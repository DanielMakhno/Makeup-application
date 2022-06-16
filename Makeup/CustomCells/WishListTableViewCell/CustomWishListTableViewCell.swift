//
//  CustomWishListTableViewCell.swift
//  Makeup
//
//  Created by Даниил Махно on 30.05.2022.
//

import UIKit
import SDWebImage

class CustomWishListTableViewCell: UITableViewCell {
    
    var product: ProductRealm? = nil
    
    @IBOutlet weak var savedProductNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    func configureCell(savedProduct: ProductRealm){
        savedProductNameLabel.text = savedProduct.name
        brandNameLabel.text = savedProduct.brand
        let url = URL(string: savedProduct.imagePath ?? "")
        productImage.sd_setImage(with: url, placeholderImage: UIImage.init(named: "NoPhotoAvailable"))
        
    }
    
}
