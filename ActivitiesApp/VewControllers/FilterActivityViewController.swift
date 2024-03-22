//
//  FilterViewController.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 19/3/24.
//

import UIKit

final class FilterActivityViewController: UIViewController {
    
    @IBOutlet var participants: UIImageView!
    @IBOutlet var type: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        participants.image = UIImage(named: "participants")
        type.image = UIImage(named: "type")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showParticipants" {
                if let participantsVC = segue.destination as? ParticipantsViewController {
                    participantsVC.fetchParticipantsActivity()
                }
            } else if segue.identifier == "showType" {
                if let typeVC = segue.destination as? TypeViewController {
                    typeVC.fetchTypeActivity()
                }
            }
        }
    
    @IBAction func participantsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showParticipants", sender: nil)
    }
    
    @IBAction func typeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showType", sender: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if identifier == "showParticipants" || identifier == "showType" {
                return true
            }
            return false
        }
}
