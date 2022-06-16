//
//  SideMenuViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 23.05.2022.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    public var delegate: SideMenuViewControllerDelegate?
    private let options = ["Home", "Category", "Brands", "Wish list"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
}

extension SideMenuViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(optionName: options[indexPath.row])
        cell.isSelected = false
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.selectedCell(indexPath.row)
    }
}

protocol SideMenuViewControllerDelegate {
    
    func selectedCell(_ row: Int)
}

