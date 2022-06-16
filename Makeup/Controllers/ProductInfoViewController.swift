//
//  ProductInfoViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 25.05.2022.
//

import UIKit
import SDWebImage
import RealmSwift
import SafariServices

class ProductInfoViewController: UIViewController {
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    // product colors views
    @IBOutlet weak var noColorsImageView: UIImageView!
    @IBOutlet weak var firstColorView: UIView!
    @IBOutlet weak var secondColorView: UIView!
    @IBOutlet weak var thirdColorView: UIView!
    @IBOutlet weak var fourthColorView: UIView!
    @IBOutlet weak var fifthColorView: UIView!
    @IBOutlet weak var sixthColorView: UIView!
    @IBOutlet weak var seventhColorView: UIView!
    @IBOutlet weak var eighthColorView: UIView!
    @IBOutlet weak var ninethColorView: UIView!
    @IBOutlet weak var tenthColorView: UIView!
    @IBOutlet weak var eleventhColorView: UIView!
    @IBOutlet weak var twelvethColorView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // buttons
    @IBOutlet weak var openProductInBrowserButton: UIButton!
    @IBOutlet weak var addToWishListButton: UIButton!
    
    // MARK: Properties
    
    var product: Product? = nil
    var savedProductRealm: ProductRealm? = nil
    
    // Setting dark status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: interface configuration
        productInfoConfiguration()
        
        // MARK: checking by id whether the product exists in database
        savedProductRealm = DataSavingManager.shared.objectProductExists(id: (product?.id)!)
        
        // MARK: Setting color views and buttons
        colorViewConfiguration()
        buttonsConfiguration()

    }
    
    // MARK: Setting product colors views
    private func colorViewConfiguration(){

        var productColors = [String]()
        
        if product?.productColorsList != nil {
            for item in product!.productColorsList {
                productColors.append(item!)
            }
        }
        
        switch productColors.count {
            
        case 12...30: twelvethColorView.backgroundColor = UIColor(hex: productColors[11], alpha: 1)
            twelvethColorView.layer.borderWidth = 2
            twelvethColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 11: eleventhColorView.backgroundColor = UIColor(hex: productColors[10], alpha: 1)
            eleventhColorView.layer.borderWidth = 2
            eleventhColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 10: tenthColorView.backgroundColor = UIColor(hex: productColors[9], alpha: 1)
            tenthColorView.layer.borderWidth = 2
            tenthColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 9: ninethColorView.backgroundColor = UIColor(hex: productColors[8], alpha: 1)
            ninethColorView.layer.borderWidth = 2
            ninethColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 8: eighthColorView.backgroundColor = UIColor(hex: productColors[7], alpha: 1)
            eighthColorView.layer.borderWidth = 2
            eighthColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 7: seventhColorView.backgroundColor = UIColor(hex: productColors[6], alpha: 1)
            seventhColorView.layer.borderWidth = 2
            seventhColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 6: sixthColorView.backgroundColor = UIColor(hex: productColors[5], alpha: 1)
            sixthColorView.layer.borderWidth = 2
            sixthColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 5: fifthColorView.backgroundColor = UIColor(hex: productColors[4], alpha: 1)
            fifthColorView.layer.borderWidth = 2
            fifthColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 4: fourthColorView.backgroundColor = UIColor(hex: productColors[3], alpha: 1)
            fourthColorView.layer.borderWidth = 2
            fourthColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 3: thirdColorView.backgroundColor = UIColor(hex: productColors[2], alpha: 1)
            thirdColorView.layer.borderWidth = 2
            thirdColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 2: secondColorView.backgroundColor = UIColor(hex: productColors[1], alpha: 1)
            secondColorView.layer.borderWidth = 2
            secondColorView.layer.borderColor = UIColor.black.cgColor
            
            fallthrough
        case 1: firstColorView.backgroundColor = UIColor(hex: productColors[0], alpha: 1)
            firstColorView.layer.borderWidth = 2
            firstColorView.layer.borderColor = UIColor.black.cgColor
            
        default:
            noColorsImageView.isHidden = false
            firstColorView.layer.borderWidth = 2
            firstColorView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func settingRatingLabel(rating: Double?) -> String {
        
        if rating == nil {
            return "★ 0.0"
        } else {
            return "★ " + String(format: "%.*f", rating!) + ".0"
        }
    }
    
    // MARK: Interface configuration
    
    private func productInfoConfiguration() {
        
        noColorsImageView.isHidden = true
        nameLabel.text = product?.name?.capitalized ?? ""
        descriptionLabel.text = product?.productDescription ?? ""
        ratingLabel.text = settingRatingLabel(rating: product?.rating)
        brandNameLabel.text = product?.brand?.capitalized ?? ""
        let imageURL = URL(string: product?.imagePath ?? "")
        productImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.init(named: "NoPhotoAvailable"))
        priceLabel.text = (product?.priceSign ?? "$") + " " + (product?.price ?? "0.0")
    }
    
    // MARK: Buttons Configuration
    private func buttonsConfiguration() {
        
        openProductInBrowserButton.backgroundColor = .white
        openProductInBrowserButton.titleLabel?.textColor = .black
        openProductInBrowserButton.layer.borderWidth = CGFloat(2)
        openProductInBrowserButton.layer.borderColor = UIColor.black.cgColor
        openProductInBrowserButton.layer.cornerRadius = 10
        
        addToWishListButton.titleLabel?.textColor = .black
        addToWishListButton.layer.borderWidth = CGFloat(2)
        addToWishListButton.layer.borderColor = UIColor.black.cgColor
        addToWishListButton.layer.cornerRadius = 10
        
        if savedProductRealm != nil {
            addToWishListButton.setTitle("Remove from Wish List", for: .normal)
        } else {
            addToWishListButton.setTitle("Add to Wish List", for: .normal)
        }
    }
    
    // MARK: Opening a product in Safari
    @IBAction func openInBrowserButtonClicked(_ sender: Any) {
        
        if product?.productLink != nil {
            let url = URL(string: (product?.productLink!)!)
            let safariViewController = SFSafariViewController(url: url!)
            present(safariViewController, animated: true)
        }
    }
    
    // MARK: Saving the product
    @IBAction func addWoWishListButtonPressed(_ sender: Any) {
        
        if savedProductRealm == nil {
            savedProductRealm = DataSavingManager.shared.saveProduct(product: product!)
            addToWishListButton.setTitle("Remove from Wish List", for: .normal)
        } else {
            DataSavingManager.shared.deleteSavedProduct(savedProduct: savedProductRealm!)
            addToWishListButton.setTitle("Add to Wish List", for: .normal)
            savedProductRealm = nil
            
        }
    }
}


// MARK: - Extension
extension UIColor {
    
    convenience init(r: UInt8, g: UInt8, b: UInt8, alpha: CGFloat = 1.0) {
        let divider: CGFloat = 255.0
        self.init(red: CGFloat(r)/divider, green: CGFloat(g)/divider, blue: CGFloat(b)/divider, alpha: alpha)
    }
    
    private convenience init(rgbWithoutValidation value: Int32, alpha: CGFloat = 1.0) {
        self.init(
            r: UInt8((value & 0xFF0000) >> 16),
            g: UInt8((value & 0x00FF00) >> 8),
            b: UInt8(value & 0x0000FF),
            alpha: alpha
        )
    }
    
    convenience init?(rgb: Int32, alpha: CGFloat = 1.0) {
        
        if rgb > 0xFFFFFF || rgb < 0 { return nil }
        self.init(rgbWithoutValidation: rgb, alpha: alpha)
    }
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        
        var charSet = CharacterSet.whitespacesAndNewlines
        charSet.insert("#")
        let _hex = hex.trimmingCharacters(in: charSet)
        guard _hex.range(of: "^[0-9A-Fa-f]{6}$", options: .regularExpression) != nil else { return nil }
        var rgb: UInt32 = 0
        Scanner(string: _hex).scanHexInt32(&rgb)
        self.init(rgbWithoutValidation: Int32(rgb), alpha: alpha)
    }
}
