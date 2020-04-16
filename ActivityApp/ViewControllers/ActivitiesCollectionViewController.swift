//
//  ActivitiesViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ActivitiesCollectionViewController: UIViewController {
    
    private let activitiesCollectionView = ActivitiesCollectionView()
    
    override func loadView() {
        view = activitiesCollectionView
        view.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.6493265629, alpha: 1)
    }
    
    private var activities = [Activity]() {
        didSet {
            DispatchQueue.main.async {
                self.activitiesCollectionView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivities()
        configureCollectionView()
        
    }
    
    private func configureCollectionView() {
        activitiesCollectionView.collectionView.register(ActivitiesCell.self, forCellWithReuseIdentifier: "activitiesCell")
        activitiesCollectionView.collectionView.delegate = self
        activitiesCollectionView.collectionView.dataSource = self
    }
    
    private func loadActivities() {
        DatabaseService.shared.getActivities { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "could not get firebase data", message: "\(error.localizedDescription)")
                }
            case .success(let activities):
                DispatchQueue.main.async {
                    self?.activities = activities
                }
                
            }
        }
    }
    
}
extension ActivitiesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let maxSize: CGFloat = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 2
        let totalSpace: CGFloat = (numberOfItems * itemSpacing) * 2.5
        let itemWidth: CGFloat = (maxSize - totalSpace) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
extension ActivitiesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = activitiesCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: "activitiesCell", for: indexPath) as? ActivitiesCell else {
            fatalError("could not cast to ActivitiesCell")
        }
        let activity = activities[indexPath.row]
        cell.activityNameLabel.text = activity.activityName
        cell.backgroundColor = #colorLiteral(red: 0.8075399399, green: 1, blue: 0.5855349302, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activity = activities[indexPath.row]
        let rulesVC = RulesViewController()
        rulesVC.activity = activity
        navigationController?.pushViewController(rulesVC, animated: true)
    }
    
    
}
