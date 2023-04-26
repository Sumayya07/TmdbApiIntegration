//
//  WatchProvidersViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 26/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class WatchProvidersViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var watchProvider: WatchProviders?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Watch Providers"
        getWatchProvidersApi()

    }

}

extension WatchProvidersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.watchProvider?.results.count) ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchProvidersTVC") as? WatchProvidersTVC else { return UITableViewCell() }
//        let item = watchProvider?.results[indexPath.row]
//        cell.lblLink.text = item?.link
    
//        cell.imgLogoPath.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(item? ?? "")")

        return cell

    }
}

extension WatchProvidersViewController {
    func getWatchProvidersApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)

            guard let url = URL(string: APIManager.shared.watchProvidersApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            APIManager.shared.load(urlRequest: request, type: WatchProviders.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.watchProvider = response
                    self.tableView.reloadData()

                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}

