//
//  MovieListViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 11/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnRecommendations: UIButton!
    
    var reachability : Reachability?
    var movieList: MovieList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Movie List"
        navigationItem.backButtonTitle = ""

        btnRecommendations.cornerRadius()
        
        getMovieListApi()
    }
    
    
    @IBAction func btnRecommendationsTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecommendationsViewController") as! RecommendationsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.movieList?.genres?.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTVC") as? MovieListTVC else { return UITableViewCell() }
        let item = movieList?.genres?[indexPath.row]
//        cell.lblMovieId.text = "\(item?.id ?? 0)"
        cell.lblMovieName.text = item?.name
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


extension MovieListViewController {
    func getMovieListApi() -> Void {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.movieListApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: MovieList.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.movieList = response
                    self.tableView.reloadData()
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
    
