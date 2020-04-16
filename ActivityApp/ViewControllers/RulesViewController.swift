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
    }
    
    private func updateUI() {
        rulesView.activityRulesLabel.text = activity?.activityRules
    }
    


}
