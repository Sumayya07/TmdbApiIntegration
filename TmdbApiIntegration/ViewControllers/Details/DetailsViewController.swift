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
    

    @IBOutlet var lblMovieName: UILabel!
    @IBOutlet var lblMovieOverview: UILabel!
    @IBOutlet var imgMoviePoster: UIImageView!
    
    @IBOutlet var btnKeywords: UIButton!
    @IBOutlet var btnChanges: UIButton!
    @IBOutlet var btnCredits: UIButton!
    @IBOutlet var btnTitles: UIButton!
    @IBOutlet var btnExternalIDs: UIButton!
    @IBOutlet var btnReviews: UIButton!
    @IBOutlet var btnReleaseDates: UIButton!
    @IBOutlet var btnSimilarMovies: UIButton!
    @IBOutlet var btnTranslations: UIButton!
    @IBOutlet var btnVideos: UIButton!
    @IBOutlet var btnWatchProviders: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "The Gray Man"
        navigationItem.backButtonTitle = ""
        
        btnKeywords.blueBorderDesign()
        btnChanges.blueBorderDesign()
        btnCredits.blueBorderDesign()
        btnTitles.blueBorderDesign()
        btnExternalIDs.blueBorderDesign()
        btnReviews.blueBorderDesign()
        btnReleaseDates.blueBorderDesign()
        btnTranslations.blueBorderDesign()
        btnVideos.blueBorderDesign()
        btnWatchProviders.blueBorderDesign()
        btnSimilarMovies.cornerRadius()
        
        getDetailsApi()
    }
    
    
    
    @IBAction func btnKeywordTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KeywordViewController") as! KeywordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnChangeTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangesViewController") as! ChangesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnCreditTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreditsViewController") as! CreditsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTitleTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TitlesViewController") as! TitlesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnExternalTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ExternalViewController") as! ExternalViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnReviewTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnReleaseTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReleaseDatesViewController") as! ReleaseDatesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnSimilarMoviesTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SimilarMoviesViewController") as! SimilarMoviesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnTranslationTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TranslationViewController") as! TranslationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnVideoTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideosViewController") as! VideosViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnWatchProviderTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WatchProvidersViewController") as! WatchProvidersViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
                    
                    self.lblMovieName.text = self.details?.title
                    self.lblMovieOverview.text = self.details?.overview
                                    
                    self.imgMoviePoster.imageFromUrl(urlString: "https://image.tmdb.org/t/p/w500\(self.details?.posterPath ?? "")")

                case .failure(let error):
                    print("error >>>>", error.localizedDescription)
                }
            }
        }
    }
}





