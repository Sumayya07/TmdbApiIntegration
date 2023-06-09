//
//  CreditsViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 05/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class CreditsViewController: UIViewController {
    
    var reachability : Reachability?
    var credits: Credits?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Cast"
        getCreditsApi()
    }
}


extension CreditsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(self.credits?.cast.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditsTVC") as? CreditsTVC else { return UITableViewCell() }
        
        let item = credits?.cast[indexPath.row]
        
        cell.viewMain.layer.cornerRadius = 20
        cell.viewMain.layer.borderWidth = 1
        cell.viewMain.layer.borderColor = UIColor(named: "Blue")?.cgColor
        cell.lblCelebrityName.text = item?.name
        cell.lblCharacter.text = item?.character
        cell.lblDepartment.text = item?.knownForDepartment.rawValue
        
        return cell

    }
}


extension CreditsViewController {
    func getCreditsApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.creditsApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Credits.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.credits = response
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}





