//
//  ActivityRulesViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    private let rulesView = RulesView()
    
    override func loadView() {
        view = rulesView
        rulesView.backgroundColor = .systemPink
    }
    
    public var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureButton()
    }
    
    private func updateUI() {
        rulesView.activityRulesLabel.text = activity?.activityRules
    }
    private func configureButton() {
        rulesView.playButton.addTarget(self, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func playButtonPressed(_ sender: UIButton) {
        if activity?.activityName == "Go Back In Time" {
            let timeVC = MattViewController()
            navigationController?.pushViewController(timeVC, animated: true)
        } else if activity?.activityName == "Storyboard Your Day" {
            let storyboardVC = LubaViewController()
            navigationController?.pushViewController(storyboardVC, animated: true)
        } else if activity?.activityName == "Record Interviews" {
            let interviewVC = CasandraViewController()
            navigationController?.pushViewController(interviewVC, animated: true)
        } else if activity?.activityName == "Personify Something" {
            let personifyVC = TiffanyViewController()
            navigationController?.pushViewController(personifyVC, animated: true)
        }
    }


}
