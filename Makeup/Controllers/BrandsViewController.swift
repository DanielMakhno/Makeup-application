//
//  BrandsViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 23.05.2022.
//

import UIKit
import RealmSwift

class BrandsViewController: UIViewController {
    
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var brandsTableView: UITableView!
    
    private let brandsList = [Brand(name: "Almay", urlPath: "almay"),
                              Brand(name: "Alva", urlPath: "alva"),
                              Brand(name: "Anna Sui", urlPath: "anna+sui"),
                              Brand(name: "Annabelle", urlPath: "annabelle"),
                              Brand(name: "Benefit", urlPath: "benefit"),
                              Brand(name: "Boosh", urlPath: "burt's+bees"),
                              Brand(name: "Burt's bees", urlPath: "maybelline"),
                              Brand(name: "Butter London", urlPath: "butter+london"),
                              Brand(name: "C'est moi", urlPath: "c'est+moi"),
                              Brand(name: "Cargo cosmetics", urlPath: "cargo+cosmetics"),
                              Brand(name: "China glaze", urlPath: "china+glaze"),
                              Brand(name: "Clinique", urlPath: "Clinique"),
                              Brand(name: "Coastal classic creation", urlPath: "coastal+classic+creation"),
                              Brand(name: "Colourpop", urlPath: "colourpop"),
                              Brand(name: "Covergirl", urlPath: "covergirl"),
                              Brand(name: "Dalish", urlPath: "dalish"),
                              Brand(name: "Deciem", urlPath: "deciem"),
                              Brand(name: "Dior", urlPath: "dior"),
                              Brand(name: "Dr. Hauschka", urlPath: "Dr.+Hauschka"),
                              Brand(name: "E.l.f.", urlPath: "E.l.f."),
                              Brand(name: "Essie", urlPath: "essie"),
                              Brand(name: "Fenty", urlPath: "fenty"),
                              Brand(name: "Glossier", urlPath: "glossier"),
                              Brand(name: "Green people", urlPath: "green+people"),
                              Brand(name: "Iman", urlPath: "iman"),
                              Brand(name: "L'oreal", urlPath: "L'oreal"),
                              Brand(name: "Lotus cosmetics USA", urlPath: "Lotus+cosmetics+USA"),
                              Brand(name: "Maia's mineral galaxy", urlPath: "maia's+mineral+galaxy"),
                              Brand(name: "marcelle", urlPath: "marcelle"),
                              Brand(name: "marienatie", urlPath: "marienatie"),
                              Brand(name: "Maybelline", urlPath: "Maybelline"),
                              Brand(name: "Milani", urlPath: "Milani"),
                              Brand(name: "Mineral", urlPath: "Mineral"),
                              Brand(name: "Fusion", urlPath: "fusion"),
                              Brand(name: "Misa", urlPath: "misa"),
                              Brand(name: "Mistura", urlPath: "mistura"),
                              Brand(name: "Moov", urlPath: "moov"),
                              Brand(name: "Nudus", urlPath: "nudus"),
                              Brand(name: "Nyx", urlPath: "nyx"),
                              Brand(name: "Orly", urlPath: "orly"),
                              Brand(name: "Pacifica", urlPath: "pacifica"),
                              Brand(name: "Penny Lane Organics", urlPath: "penny+Lane+organics"),
                              Brand(name: "Physicians", urlPath: "pysicians"),
                              Brand(name: "Piggy paint", urlPath: "piggy+paint"),
                              Brand(name: "Pure anada", urlPath: "pure+anada"),
                              Brand(name: "Rejuva minerals", urlPath: "Rejuva+minerals"),
                              Brand(name: "Revlon", urlPath: "revlon"),
                              Brand(name: "Sally B's Skin Yummies", urlPath: "Sally+B's+Skin+Yummies"),
                              Brand(name: "Salon perfect", urlPath: "salon+perfect"),
                              Brand(name: "Sante", urlPath: "sante"),
                              Brand(name: "Sinful colours",urlPath: "sinful+colours"),
                              Brand(name: "Smashbox", urlPath: "smashbox"),
                              Brand(name: "Stila", urlPath: "stila"),
                              Brand(name: "W3llpeople", urlPath: "W3llpeople"),
                              Brand(name: "Wet'n'wild", urlPath: "Wet+n+wild"),
                              Brand(name: "Zorah", urlPath: "zorah"),
                              Brand(name: "Zorah biocosmetiques", urlPath: "zorah+biocosmetiques")]
    
    private var duplicateBrandsList = [Brand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Brands"
        
        // MARK: SearchBar
        
        searchBar.delegate = self
        duplicateBrandsList = brandsList
        
        // MARK: Side Menu Bar
        
        sideMenuButton.target = revealViewController()
        sideMenuButton.action = #selector(revealViewController()?.revealSideMenu)
        
        brandsTableView.dataSource = self
        brandsTableView.delegate = self
        
        // MARK: Registering a custom cell
        
        brandsTableView.register(UINib(nibName: "BrandTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandTableViewCell")
    }
}

// MARK: - UITableViewDataSource

extension BrandsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        duplicateBrandsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BrandTableViewCell", for: indexPath) as? BrandTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(brand: duplicateBrandsList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}
// MARK: - UITableViewDelegate

extension BrandsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let brand = duplicateBrandsList[indexPath.row]
        let url = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=" + brand.urlPath
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailsViewController = main.instantiateViewController(withIdentifier: "DetailedCategoryViewController") as? BrandsAndCategoryResultsViewController {
            detailsViewController.title = brand.name
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
            
            DispatchQueue.main.async {
                
                let productsRequest = NetworkManager.shared.loadProductList(url: url) { results in
                    
                    detailsViewController.results = results
                    detailsViewController.duplicateResultsList = results
                    
                    detailsViewController.detailedCollectionView.stopSkeletonAnimation()
                    detailsViewController.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    
                    detailsViewController.detailedCollectionView.reloadData()
                    
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension BrandsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        
        duplicateBrandsList = brandsList
        brandsTableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        duplicateBrandsList = searchText.isEmpty ? brandsList : brandsList.filter({ model in
            return model.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        brandsTableView.reloadData()
    }
}
