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
    func fetchActivity() {
        guard let url = URL(string: "https://www.boredapi.com/api/activity?type=\(selectedType)") else {
            print("Invalid URL")
            return
        }
        networkManager.fetchActivity(from: url) { [weak self] result in
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
    @IBAction func ReloadButton(_ sender: Any) {
        fetchActivity()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
