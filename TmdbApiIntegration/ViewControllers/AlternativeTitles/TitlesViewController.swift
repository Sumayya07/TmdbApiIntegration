//
//  TitlesViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 30/03/23.
//

import UIKit
import Reachability
import MBProgressHUD

class TitlesViewController: UIViewController {
    
    var reachability : Reachability?
    var titles: Titles?
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Alternative Titles"
        getAlternativeTitlesApi()


    }
}


extension TitlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.titles?.titles.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitlesTVC") as? TitlesTVC else { return UITableViewCell() }
    
        let item = titles?.titles[indexPath.row]
        cell.lblTitleOne.text = item?.iso3166_1
        cell.lblTitleTwo.text = item?.title
        return cell

    }
    
    
    
}

extension TitlesViewController {
    func getAlternativeTitlesApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.titlesApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Titles.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.titles = response
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
