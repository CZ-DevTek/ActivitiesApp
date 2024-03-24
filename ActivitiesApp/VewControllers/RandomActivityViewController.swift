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
    
    private func fetchActivity() {
        NetworkManager.shared.fetchActivity(from: Link.randomURL.url) { [unowned self] result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                switch result {
                    case .success(let activities):
                        if let activity = activities.first {
                            self.updateUI(with: activity)
                        }
                    case .failure(let error):
                        print("Error fetching random activity: \(error)")
                }
            }
        }
    }
    private func updateUI(with activity: Activity) {
        activityLabel.text = "Activity: \(activity.activity)"
        typeLabel.text = "Type of Activity: \(activity.type)"
        participantsLabel.text = "Number of participants: \(activity.participants)"
        priceLabel.text = "Price in BitCoins: \(activity.price)"
    }
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
        fetchActivity()
    }
    
}
