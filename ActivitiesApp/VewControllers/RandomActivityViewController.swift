//
//  DetailViewController.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 17/3/24.
//

import UIKit

final class RandomActivityViewController: UIViewController {
    
    
    @IBOutlet var activityLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var participantsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var reloadButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLabel.layer.cornerRadius = 15
        typeLabel.layer.cornerRadius = 15
        participantsLabel.layer.cornerRadius = 15
        priceLabel.layer.cornerRadius = 15
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchActivity()
    }
    
    func fetchActivity() {
        NetworkManager.shared.fetch(Activity.self, from: Link.randomURL.url) { [weak self] result in
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
                    print("Error fetching random activity: \(error)")
            }
        }
    }
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
            fetchActivity()
        }
}
