//
//  BrandsAndCategoryResultsViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 25.05.2022.
//

import UIKit
import SkeletonView


class BrandsAndCategoryResultsViewController: UIViewController {
    
    @IBOutlet weak var detailedCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    
    public var results: [Product] = []
    public var duplicateResultsList: [Product] = []
    
    // Setting dark status bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SearchBar
        searchBar.delegate = self
        
        // CollectionView
        detailedCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Checking if there are search results to disable Skeleton
        if results.isEmpty {
            
            detailedCollectionView.isSkeletonable = true
            detailedCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.25))
            
        }
    }
}

    // MARK: - Extensions

    // MARK: UICollectionViewDataSource
extension BrandsAndCategoryResultsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        duplicateResultsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell {
            cell.configureCell(item: results[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

}

    // MARK: UICollectionViewDelegateFlowLayout
extension BrandsAndCategoryResultsViewController: UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = duplicateResultsList[indexPath.row]
        let main = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = main.instantiateViewController(withIdentifier: "ProductInfoViewController") as? ProductInfoViewController {
            
            detailsViewController.product = product
  
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

    // MARK: UISearchBar
extension BrandsAndCategoryResultsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        
        duplicateResultsList = results
        detailedCollectionView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        duplicateResultsList = searchText.isEmpty ? results : results.filter({ model in
            return model.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        detailedCollectionView.reloadData()
    }
}

    // MARK: Skeleton
extension BrandsAndCategoryResultsViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "CustomCollectionViewCell"
    }
    
}
