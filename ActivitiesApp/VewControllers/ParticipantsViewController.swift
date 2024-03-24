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
    @IBOutlet var participantsTitle: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var selectedParticipants: Int = 0
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        participantsTitle.text = "\(selectedParticipants)"
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchActivity()
    }
    
    private func fetchActivity() {
        let participantsURL = Link.participantsURL(selectedParticipants)
        let url = participantsURL.url
        NetworkManager.shared.fetchActivity(from: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                switch result {
                    case .success(let activity):
                        self.updateUI(with: activity)
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
    @IBAction func reloadButton(_ sender: Any) {
        fetchActivity()
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
