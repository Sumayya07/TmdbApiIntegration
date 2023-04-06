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

    @IBOutlet var idLbl: UILabel!
    @IBOutlet var imdbLbl: UILabel!
    @IBOutlet var facebookLbl: UILabel!
    @IBOutlet var instagramLbl: UILabel!
    @IBOutlet var twitterLbl: UILabel!
    
    var reachability: Reachability?
    var external: External?

    override func viewDidLoad() {
        super.viewDidLoad()
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
                    
                    self.idLbl.text = self.external?.id
//                    self.imdbLbl.text = self.external?.imdbID
//                    self.facebookLbl.text = self.external?.facebookID
//                    self.instagramLbl.text = self.external?.instagramID
//                    self.twitterLbl.text = self.external?.twitterID
                    
                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}
