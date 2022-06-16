//
//  ProductViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 23.05.2022.
//

import UIKit
import SkeletonView

class CategoryViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    private let categories = [Category(name: "Blush", imagePath: "blush", urlPath: "blush"),
                      Category(name: "Bronzer", imagePath: "bronzer", urlPath: "bronzer"),
                      Category(name: "Eyebrow", imagePath: "eyebrow", urlPath: "eyebrow"),
                      Category(name: "Eyeliner", imagePath: "eyeliner", urlPath: "eyeliner"),
                      Category(name: "Lip liner", imagePath: "lipliner", urlPath: "lip+liner"),
                      Category(name: "Eyeshadow", imagePath: "eyeshadow", urlPath: "eyeshadow"),
                      Category(name: "Lipstick", imagePath: "lipstick", urlPath: "lipstick"),
                      Category(name: "Mascara",  imagePath: "mascara", urlPath: "mascara"),
                      Category(name: "Nail polish", imagePath: "nailpolish",  urlPath: "nail+polish")]
    
    private var duplicateCategoryList = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        // MARK: SearchBar
        searchBar.delegate = self
        duplicateCategoryList = categories
        
        // MARK: Side Menu
        sideMenuButton.target = revealViewController()
        sideMenuButton.action = #selector(revealViewController()?.revealSideMenu)
        
        // MARK: TableView
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
       
    }
   
}

    // MARK: - Extensions

    // MARK: UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        duplicateCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        let category = duplicateCategoryList[indexPath.row]
        cell.configureCell(category: category)
        cell.selectionStyle = .none
        return cell
    }
    
}
    
    // MARK: UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = duplicateCategoryList[indexPath.row]
        let url = "https://makeup-api.herokuapp.com/api/v1/products.json?product_type=" + category.urlPath
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailsViewController = main.instantiateViewController(withIdentifier: "DetailedCategoryViewController") as? BrandsAndCategoryResultsViewController {
            detailsViewController.title = category.name
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
            
            // MARK: New thread to get category results
            
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

extension CategoryViewController: UISearchBarDelegate {
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        
        duplicateCategoryList = categories
        tableView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        duplicateCategoryList = searchText.isEmpty ? categories : categories.filter({ model in
            return model.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
    }
}
