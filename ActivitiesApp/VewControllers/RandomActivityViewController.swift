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
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var url: URL {
        return URL(string: "https://www.boredapi.com/api/activity/")!
    }
    
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
            URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
                guard let data = data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let activity = try decoder.decode(Activity.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.activityLabel.text = "Activity: \(activity.activity)"
                        self.typeLabel.text = "Type of Activity: \(activity.type)"
                        self.participantsLabel.text = "Number of participants: \(activity.participants)"
                        self.priceLabel.text = "Price in BitCoins: \(activity.price)"
                        self.activityIndicator.stopAnimating()
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
