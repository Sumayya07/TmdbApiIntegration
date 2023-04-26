//
//  NowPlayingViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 26/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class NowPlayingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var playing: NowPlaying?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "List of Movies in Theatres"
        getNowPlayingApi()

    }

}

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.playing?.results.count) ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingTVC") as? NowPlayingTVC else { return UITableViewCell() }
        let item = playing?.results[indexPath.row]
        cell.lblMovieName.text = item?.title
        cell.lblMovieOverview.text = item?.overview
        cell.lblDate.text = item?.releaseDate
        cell.imgPosterOne.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(item?.posterPath ?? "")")
        cell.imgPosterTwo.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(item?.backdropPath ?? "")")
        return cell

    }
}

extension NowPlayingViewController {
    func getNowPlayingApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)

            guard let url = URL(string: APIManager.shared.nowPlayingApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            APIManager.shared.load(urlRequest: request, type: NowPlaying.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.playing = response
                    self.tableView.reloadData()

                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}

