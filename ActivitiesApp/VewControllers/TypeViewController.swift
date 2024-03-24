//
//  TypeViewController.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 19/3/24.
//

import UIKit

final class TypeViewController: UIViewController {
    
    @IBOutlet var activityLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var participantsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var typeTitle: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var selectedType: String = ""
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTitle.text = "\(selectedType)"
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchActivity()
    }
    private func fetchActivity() {
        let typeURL = Link.typeURL(selectedType)
        let url = typeURL.url
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
    @IBAction func ReloadButton(_ sender: Any) {
        fetchActivity()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
