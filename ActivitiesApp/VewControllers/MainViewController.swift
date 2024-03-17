//
//  ViewController.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 17/3/24.
//

import UIKit

var url = URL(string: "https://www.boredapi.com/api/activity/")!

enum UserAction: CaseIterable {
    case activity
    
    var title: String {
        switch self {
        case .activity:
            return "Show Activity"

        }
    }
}

final class MainViewController: UICollectionViewController {
    private let userActions = UserAction.allCases

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActionCell", for: indexPath)
        guard let cell = cell as? ActivityCell else { return UICollectionViewCell() }
        cell.titleLabel.text = userActions[indexPath.item].title
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .activity:
            fetchActivity()
        }
    }

    // MARK: - Private Methods
    
    private func fetchActivity() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let activity = try JSONDecoder().decode(Activity.self, from: data)
                print(activity)
            } catch {
                print(error)
            }
        }.resume()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: (view.window?.windowScene?.screen.bounds.width ?? 0) - 48,
            height: 100
        )
    }
}
