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
    @IBOutlet var participantsButton: UIButton!
    @IBOutlet var typeButton: UIButton!
    
    var selectedParticipants: Int = 0
    var selectedType: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        participants.image = UIImage(named: "participants")
        type.image = UIImage(named: "type")
        setupParticipantsContextMenu()
        setupTypeContextMenu()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showParticipants" {
            if let participantsVC = segue.destination as? ParticipantsViewController {
                participantsVC.selectedParticipants = selectedParticipants
            }
        } else if segue.identifier == "showType" {
            if let typeVC = segue.destination as? TypeViewController {
                typeVC.selectedType = selectedType
            }
        }
    }
    
    func setupParticipantsContextMenu() {
        let participantsMenu = UIMenu(title: "Participants", children: (1...5).map { number in
            UIAction(title: "\(number)", handler: { [weak self] _ in
                self?.handleParticipantsSelection(number)
            })
        })
        participantsButton.showsMenuAsPrimaryAction = true
        participantsButton.menu = participantsMenu
    }
    
    func setupTypeContextMenu() {
        let typeMenu = UIMenu(title: "Type", children: [
            UIAction(title: "Education", handler: { [weak self] _ in
                self?.handleTypeSelection("education")
            }),
            UIAction(title: "Recreational", handler: { [weak self] _ in
                self?.handleTypeSelection("recreational")
            }),
            UIAction(title: "Social", handler: { [weak self] _ in
                self?.handleTypeSelection("social")
            }),
            UIAction(title: "DIY", handler: { [weak self] _ in
                self?.handleTypeSelection("diy")
            }),
            UIAction(title: "Charity", handler: { [weak self] _ in
                self?.handleTypeSelection("charity")
            }),
            UIAction(title: "Cooking", handler: { [weak self] _ in
                self?.handleTypeSelection("cooking")
            }),
            UIAction(title: "Relaxation", handler: { [weak self] _ in
                self?.handleTypeSelection("relaxation")
            }),
            UIAction(title: "Music", handler: { [weak self] _ in
                self?.handleTypeSelection("music")
            }),
            UIAction(title: "Busywork", handler: { [weak self] _ in
                self?.handleTypeSelection("busywork")
            })
        ])
        typeButton.showsMenuAsPrimaryAction = true
        typeButton.menu = typeMenu
    }
    
    func handleParticipantsSelection(_ number: Int) {
        selectedParticipants = number
        performSegue(withIdentifier: "showParticipants", sender: nil)
    }
    
    func handleTypeSelection(_ type: String) {
        selectedType = type
        performSegue(withIdentifier: "showType", sender: nil)
    }
    
    @IBAction func participantsButtonPressed(_ sender: Any) {
        handleParticipantsSelection(selectedParticipants)
        performSegue(withIdentifier: "showParticipants", sender: nil)
    }
    
    @IBAction func typeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showType", sender: nil)
    }
}
