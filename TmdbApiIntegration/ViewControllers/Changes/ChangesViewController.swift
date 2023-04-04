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
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChanges()
        
        lbl1.layer.cornerRadius = 10
        lbl2.layer.cornerRadius = 10
        lbl3.layer.cornerRadius = 10

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
                                        self.lbl1.text = items[0].action
                                        self.lbl2.text = items[0].id
                                        self.lbl3.text = items[0].originalValue
                                    }
                                }
                                
                            case .failure(let error):
                                print("error >>>>", error.localizedDescription)
                            }
                        }
        }
    }
}

