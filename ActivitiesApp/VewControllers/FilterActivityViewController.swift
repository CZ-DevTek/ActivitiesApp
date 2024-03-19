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
    @IBAction func participantsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showParticipants", sender: nil)
        }
    
    @IBAction func typeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showType", sender: nil)
        }
}
