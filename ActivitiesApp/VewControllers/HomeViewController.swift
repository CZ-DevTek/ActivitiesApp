//
//  HomeViewController.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 20/3/24.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet var imageTitle: UIImageView!
    @IBOutlet var imageBody: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTitle.image = UIImage(named: "activities")
        imageBody.image = UIImage(named: "activities2")
    }
}
