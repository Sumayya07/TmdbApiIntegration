//
//  SimilarMoviesViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 18/04/23.
//

import UIKit
import MBProgressHUD
import Reachability

class SimilarMoviesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var similarMovies: SimilarMovies?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Similar Movies"
        getSimilarMoviesApi()

    }

}

extension SimilarMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.similarMovies?.results.count) ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMoviesTVC") as? SimilarMoviesTVC else { return UITableViewCell() }
        let item = similarMovies?.results[indexPath.row]
        cell.lblMovieTitle.text = item?.title
        cell.lblMovieOverview.text = item?.overview
        cell.imgMoviePoster.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(item?.posterPath ?? "")")
        return cell

    }
}

extension SimilarMoviesViewController {
    func getSimilarMoviesApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)

            guard let url = URL(string: APIManager.shared.similarMovies) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            APIManager.shared.load(urlRequest: request, type: SimilarMovies.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.similarMovies = response
                    self.tableView.reloadData()

                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}

