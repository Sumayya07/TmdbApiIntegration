//
//  ReleaseDatesViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 17/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class ReleaseDatesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
        var reachability: Reachability?
        var releaseDates: [Release_dates] = []
    
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.navigationBar.isHidden = false
            navigationItem.title = "Release Dates"
            getReleaseDatesApi()
    
        }
    
    }
    
    extension ReleaseDatesViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return releaseDates.count
    
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseDatesTVC") as? ReleaseDatesTVC else { return UITableViewCell() }
            let item = releaseDates[indexPath.row]
            cell.lblCountry.text = item.iso_639_1
            cell.lblReleaseDates.text =  item.release_date
            return cell
    
        }
    }
    
    extension ReleaseDatesViewController {
        func getReleaseDatesApi() {
            do {
                self.reachability = try Reachability.init()
            } catch {
                print("Unable tp start notifier")
            }
            if ((reachability?.connection) != .unavailable) {
                MBProgressHUD.showAdded(to: self.view, animated: true)
    
                guard let url = URL(string: APIManager.shared.releaseDatesApi) else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
                APIManager.shared.load(urlRequest: request, type: [Release_dates].self) { result in
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    switch result {
                    case .success(let response):
                        self.releaseDates = response
                        self.tableView.reloadData()
    
                    case .failure(let error):
                        print("error >>>>", error.localizedDescription)
                    }
                }
            }
        }
    }

