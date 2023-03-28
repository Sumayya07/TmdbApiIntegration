//
//  ViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 28/03/23.
//

import UIKit
import Reachability
import MBProgressHUD

class DetailsViewController: UIViewController {
    
    var reachability : Reachability?
    var details: Details?

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailsApi()
        
        
    }


}

extension DetailsViewController {
    func getDetailsApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.detailsApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Details.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.details = response
//                    self.tableView.reloadData()
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}

