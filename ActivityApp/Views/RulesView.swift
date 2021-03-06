//
//  RulesView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class RulesView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        playButton.clipsToBounds = true
        playButton.layer.cornerRadius = 13
    }
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Rules"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 30)
        return label
    }()
    
    public lazy var activityRulesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    public lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        rulesLabelConstraints()
        titleLabelConstraints()
        playButtonConstraints()
    }

    private func rulesLabelConstraints() {
        addSubview(activityRulesLabel)
        activityRulesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityRulesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityRulesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityRulesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            activityRulesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    private func titleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: activityRulesLabel.topAnchor, constant: -10)
        ])
    }
    private func playButtonConstraints() {
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: activityRulesLabel.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
