//
//  ReviewsViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 18/04/23.
//

import UIKit
import MBProgressHUD
import Reachability

class ReviewsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var reachability: Reachability?
    var recommendation: Recommendations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Reviews"
        getReviewsApi()

    }

}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.recommendation?.results.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTVC") as? ReviewsTVC else { return UITableViewCell() }
//        let item = recommendation?.results[indexPath.row]
//        cell.lblMovieTitle.text = item?.title
//        cell.lblMovieOverview.text = item?.overview
        cell.lblName.layer.cornerRadius = 14
        cell.lblName.layer.borderWidth = 1
        cell.lblName.layer.borderColor = UIColor(named: "Blue")?.cgColor
        
        cell.lblReview.layer.cornerRadius = 14
        cell.lblReview.layer.borderWidth = 1
        cell.lblReview.layer.borderColor = UIColor(named: "Blue")?.cgColor
        return cell

    }
}

extension ReviewsViewController {
    func getReviewsApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.reviewsApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Recommendations.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.recommendation = response
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}

