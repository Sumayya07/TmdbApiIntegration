//
//  PopularViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 26/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class PopularViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var popular: PopularMovies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Popular Movies"

        getPopularMoviesApi()

    }

}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.popular?.results.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTVC") as? PopularTVC else { return UITableViewCell() }
        let item = popular?.results[indexPath.row]
        cell.lblName.text = item?.originalTitle
        cell.lblOverview.text = item?.overview
        cell.imgPoster.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(item?.posterPath ?? "")")
        return cell

    }
}

extension PopularViewController {
    func getPopularMoviesApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.popularApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: PopularMovies.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.popular = response
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
