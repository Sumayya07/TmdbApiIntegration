//
//  UpcomingViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 26/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class UpcomingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var upcomingMovie: UpcomingMovies?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Top Rated Movies"
        getUpcomingMoviesApi()

    }

}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.upcomingMovie?.results.count) ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMovieTVC") as? UpcomingMovieTVC else { return UITableViewCell() }
        let item = upcomingMovie?.results[indexPath.row]
        cell.lblMovieName.text = item?.title
        cell.lblMovieOverview.text = item?.overview
        cell.imgPosterOne.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(item?.posterPath ?? "")")
        return cell

    }
}

extension UpcomingViewController {
    func getUpcomingMoviesApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)

            guard let url = URL(string: APIManager.shared.upcomingMoviesApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            APIManager.shared.load(urlRequest: request, type: UpcomingMovies.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.upcomingMovie = response
                    self.tableView.reloadData()

                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
