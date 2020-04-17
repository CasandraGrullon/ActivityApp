//
//  TiffanyView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class DoodleView: UIView {
    
    var lines = [[CGPoint]]()
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        guard let context = UIGraphicsGetCurrentContext() else { return
        }
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(5)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            
        }
        
        context.strokePath()
            
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    func clearStrokes(){
          lines.removeAll()
        setNeedsDisplay()
      }

}

class TiffanyView: UIView {
    
    public lazy var doodleView: DoodleView = {
        let view = DoodleView()
        view.backgroundColor = .clear
        return view
    }()
    
    public lazy var imageView : UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           return imageView
       }()
    
   public lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.tag = 0
//        button.backgroundColor = .systemBackground
        button.setBackgroundImage(UIImage(systemName: "video.fill"), for: .normal)
    button.tintColor = .cyan
        return button
    }()
    public lazy var libraryButton: UIButton = {
        let button = UIButton()
        button.tag = 1
//        button.backgroundColor = .systemBackground
        button.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        
        return button
    }()
    public lazy var randomPhotoButton: UIButton = {
        let button = UIButton()
        button.tag = 2
//        button.backgroundColor = .systemBackground
        button.setBackgroundImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        button.tintColor = .green
        return button
    }()
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.tag = 3
//        button.backgroundColor = .systemBackground
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.down.on.square"), for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    public lazy var clearButton: UIButton = {
            let button = UIButton()
            button.tag = 4
    //        button.backgroundColor = .systemBackground
            button.setBackgroundImage(UIImage(systemName: "multiply"), for: .normal)
        button.tintColor = .magenta
            return button
        }()
    
    private lazy var stackView : UIStackView = {
       let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 2
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame:UIScreen.main.bounds)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commomInit()
    }
    
    private func commomInit() {
        setUpImageView()
        setUpDoodleView()
        setUpStackView()
    }
    
    func setUpImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75)
            
        
        
        ])
    }
    
    
    func setUpDoodleView(){
        addSubview(doodleView)
        doodleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            doodleView.topAnchor.constraint(equalTo: topAnchor),
            doodleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            doodleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            doodleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75)
            
        
        
        ])
    }
    
    func setUpStackView(){
        addSubview(stackView)
        stackView.addArrangedSubview(cameraButton)
        stackView.addArrangedSubview(libraryButton)
        stackView.addArrangedSubview(randomPhotoButton)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(clearButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10
            )
        
        
        
        ])
    }
    
}
