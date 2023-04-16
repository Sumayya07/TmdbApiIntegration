//
//  ChangesViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 02/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class ChangesViewController: UIViewController {
    
    var reachability : Reachability?
    var changes: Changes?
    
    @IBOutlet var lblAction: UILabel!
    @IBOutlet var lblOriginalValue: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Changes"
        navigationItem.backButtonTitle = "Titles"
        
        getChanges()

    }
    
}


extension ChangesViewController {
    func getChanges() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.changesApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Changes.self) { result in
                            DispatchQueue.main.async {
                                MBProgressHUD.hide(for: self.view, animated: true)
                            }
                            switch result {
                            case .success(let response):
                                self.changes = response
                                if let changes = self.changes?.changes, changes.count > 0 {
                                    let items = changes[0].items
                                    if items.count > 0 {
                                        self.lblAction.text = items[0].action
                                        self.lblOriginalValue.text = items[0].originalValue
                                    }
                                }
                                
                            case .failure(let error):
                                print("error >>>>", error.localizedDescription)
                            }
                        }
        }
    }
}

