//
//  CustomTableViewCell.swift
//  Makeup
//
//  Created by Даниил Махно on 23.05.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var optionNamelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(optionName: String){
        self.optionNamelabel.text = optionName
    }
}
