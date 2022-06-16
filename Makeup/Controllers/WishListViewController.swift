//
//  WishListViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 23.05.2022.
//

import UIKit
import RealmSwift

class WishListViewController: UIViewController {
    
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var wishListTableView: UITableView!
    
    private var productList = [ProductRealm]()
    
    // seting darl status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productList = DataSavingManager.shared.getProductsList()
        wishListTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Wish list"
        //Side menu
        sideMenuButton.target = revealViewController()
        sideMenuButton.action = #selector(revealViewController()?.revealSideMenu)
        
        // TableView
        wishListTableView.register(UINib(nibName: "CustomWishListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomWishListTableViewCell")
        
    }
}

 // MARK: - Extension

extension WishListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomWishListTableViewCell", for: indexPath) as? CustomWishListTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(savedProduct: productList[indexPath.row])
        cell.product = productList[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            wishListTableView.beginUpdates()
            DataSavingManager.shared.deleteSavedProduct(savedProduct: productList[indexPath.row])
            productList.remove(at: indexPath.row)
            wishListTableView.deleteRows(at: [indexPath], with: .fade)
            wishListTableView.endUpdates()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productRealm = productList[indexPath.row]
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailsViewController = main.instantiateViewController(withIdentifier: "ProductInfoViewController") as? ProductInfoViewController {
            let product = Product(productRealm: productRealm)
            detailsViewController.product = product
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}



