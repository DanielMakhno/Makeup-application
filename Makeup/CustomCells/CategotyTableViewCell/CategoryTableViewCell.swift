//
//  CategoryTableViewCell.swift
//  Makeup
//
//  Created by Даниил Махно on 24.05.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(category: Category) {
        categoryName.text = category.name
        categoryImage.image = UIImage.init(named: category.imagePath!)
        
    }
}
