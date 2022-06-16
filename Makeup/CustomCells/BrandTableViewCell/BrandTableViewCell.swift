//
//  BrandTableViewCell.swift
//  Makeup
//
//  Created by Даниил Махно on 25.05.2022.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandNameLabel: UILabel!
    
    func configureCell(brand: Brand) {
        
        brandNameLabel.text = brand.name
    }
    
}
