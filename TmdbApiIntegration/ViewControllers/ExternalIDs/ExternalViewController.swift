//
//  ExternalViewController.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 05/04/23.
//

import UIKit
import Reachability
import MBProgressHUD

class ExternalViewController: UIViewController {

    @IBOutlet var lblID: UILabel!
    @IBOutlet var lblImdbId: UILabel!
    @IBOutlet var lblFacebookId: UILabel!
    @IBOutlet var lblInstagramId: UILabel!
    @IBOutlet var lblTwitterId: UILabel!
    
    var reachability: Reachability?
    var external: External?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "External IDs"
        getExternalApi()

    }

}

extension ExternalViewController {
    func getExternalApi() {
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable tp start notifier")
        }
        if ((reachability?.connection) != .unavailable) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let url = URL(string: APIManager.shared.externalApi) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            APIManager.shared.load(urlRequest: request, type: External.self) { result in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                switch result {
                case .success(let response):
                    self.external = response
                    
                    self.lblID.text = self.external?.id.description
                    self.lblImdbId.text = self.external?.imdbID.description
//                    self.lblFacebookId.text = self.external?.facebookID
//                    self.lblInstagramId.text = self.external?.instagramID
//                    self.lblTwitterId.text = self.external?.twitterID
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
