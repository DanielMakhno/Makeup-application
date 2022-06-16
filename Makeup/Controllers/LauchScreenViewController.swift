//
//  LauchScreenViewController.swift
//  Makeup
//
//  Created by Даниил Махно on 08.06.2022.
//

import UIKit

class LauchScreenViewController: UIViewController {
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 5) {
            
            self.leftConstraint.constant = 1000
            self.view.layoutIfNeeded()
            
        } completion: { complete in
            
            if let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                
                newViewController.modalTransitionStyle = .crossDissolve
                newViewController.modalPresentationStyle = .overCurrentContext
                
                self.present(newViewController, animated: true)
            }
        }
    }
}


