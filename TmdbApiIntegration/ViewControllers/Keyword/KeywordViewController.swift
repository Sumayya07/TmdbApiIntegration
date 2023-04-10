//
//  KeywordViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 06/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class KeywordViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var keyword: Keywords?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getKeywordsApi()

    }

}

extension KeywordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.keyword?.keywords.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordTVC") as? KeywordTVC else { return UITableViewCell() }
        let item = keyword?.keywords[indexPath.row]
        cell.idLbl.text = "\(item?.id ?? 0)"
        cell.nameLbl.text = item?.name
        return cell

    }
}

extension KeywordViewController {
    func getKeywordsApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.keywordApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Keywords.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.keyword = response
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
