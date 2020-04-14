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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
