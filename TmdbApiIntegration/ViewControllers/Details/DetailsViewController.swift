//
//  ViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 28/03/23.
//

import UIKit
import Reachability
import MBProgressHUD

class DetailsViewController: UIViewController {
    
    var reachability : Reachability?
    var details: Details?
    

    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var myImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailsApi()
        
        
    }


}

extension DetailsViewController {
    func getDetailsApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.detailsApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: Details.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.details = response
                    
                    self.lbl1.text = self.details?.title
                    self.lbl2.text = self.details?.overview
                                    
                    self.myImg.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(self.details?.posterPath ?? "")")
                    
//                    print("https://image.tmdb.org/t/p/w500\(self.details?.posterPath ?? "")")
                    

                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}





