//
//  IntroViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 15/04/23.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet var btnExplore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
        btnExplore.cornerRadius()

    }
    
    @IBAction func btnExploreTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
