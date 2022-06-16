//
//  HomeViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 23.05.2022.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController, SkeletonCollectionViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    
    
    // MARK: -  Preperties
    
   private var products: [Product] = []
   private var duplicateResults = [Product]()
    
    // Setting dark status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let url = "https://makeup-api.herokuapp.com/api/v1/products.json?rating_greater_than4&price_greater_than10"
        let results = NetworkManager.shared.loadProductList(url: url) { response in
            
            self.products = response
            self.duplicateResults = response
            
            // MARK: Skeleton
            
            self.collectionView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.collectionView.reloadData()
        }
        
        title = "Home"
        searchBar.delegate = self

        sideMenuButton.target = revealViewController()
        sideMenuButton.action = #selector(revealViewController()?.revealSideMenu)
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Checking if there are search results to disable Skeleton
        if products.isEmpty {
            
            collectionView.isSkeletonable = true
            collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.25))
            
        }
    }
}

    // MARK: - Data Source

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return duplicateResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell {
            cell.configureCell(item: duplicateResults[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

    // MARK: - Delegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = duplicateResults[indexPath.row]
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        if let ProductInfoViewController = main.instantiateViewController(withIdentifier: "ProductInfoViewController") as? ProductInfoViewController {
            
            ProductInfoViewController.product = product
            self.navigationController?.pushViewController(ProductInfoViewController, animated: true)
        }
    }
    
    // MARK: - Setting rows
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat
        
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            columns = 6
        } else {
            columns = 2
        }
        
        let spacing: CGFloat = 24
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth * 2)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "CustomCollectionViewCell"
    }
}


// MARK: - SearchBar

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.endEditing(true)
        
        duplicateResults = products
        collectionView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        duplicateResults = searchText.isEmpty ? products : products.filter({ model in
            return model.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        collectionView.reloadData()
    }
}
