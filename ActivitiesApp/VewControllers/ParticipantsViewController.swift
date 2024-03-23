//
//  ParticipantsViewController.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 19/3/24.
//

import UIKit

final class ParticipantsViewController: UIViewController {
    
    @IBOutlet var activityLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var participantsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchActivity()
    }

    func fetchActivity() {
        networkManager.fetch(Activity.self, from: Link.participantsURL.url) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let activity):
                    DispatchQueue.main.async {
                        self.activityLabel.text = "Activity: \(activity.activity)"
                        self.typeLabel.text = "Type of Activity: \(activity.type)"
                        self.participantsLabel.text = "Number of participants: \(activity.participants)"
                        self.priceLabel.text = "Price in BitCoins: \(activity.price)"
                        self.activityIndicator.stopAnimating()
                    }
                case .failure(let error):
                    print("Error fetching activity for single participant: \(error)")
            }
        }
    }
}
