//
//  MainVC.swift
//  ScratchCardDemo
//
//  Created by Khaled Rahman Ayon on 18.02.20.
//  Copyright © 2020 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class MainVC: UIViewController, ScratchCardDelegate {
    
    
    
    let viewBehindScratchCard = UIView()
    let previewView = ScratchCardView(image: UIImage(named: "test")!)
    let progressLabel = UILabel()

    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        
        previewView.scratchDelegate = self
        
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset Image", for: .normal)
        resetButton.backgroundColor = .white
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(handleReserButton), for: .touchUpInside)
        view.addSubview(resetButton)
        

        viewBehindScratchCard.isUserInteractionEnabled = true
        viewBehindScratchCard.backgroundColor = .red
      
       viewBehindScratchCard.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(viewBehindScratchCard)
       
       viewBehindScratchCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       viewBehindScratchCard.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       viewBehindScratchCard.widthAnchor.constraint(equalToConstant: 400).isActive = true
       viewBehindScratchCard.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        let couponView = UIImageView(image: UIImage(named: "cola"))
        couponView.contentMode = .scaleAspectFit
        couponView.translatesAutoresizingMaskIntoConstraints = false
        viewBehindScratchCard.addSubview(couponView)

        couponView.topAnchor.constraint(equalTo: viewBehindScratchCard.topAnchor).isActive = true
        couponView.bottomAnchor.constraint(equalTo: viewBehindScratchCard.bottomAnchor).isActive = true
        couponView.leadingAnchor.constraint(equalTo: viewBehindScratchCard.leadingAnchor).isActive = true
        couponView.trailingAnchor.constraint(equalTo: viewBehindScratchCard.trailingAnchor).isActive = true
        
        
//        previewView.backgroundColor = .clear
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.isUserInteractionEnabled = true
        viewBehindScratchCard.addSubview(previewView)
        
        previewView.topAnchor.constraint(equalTo: viewBehindScratchCard.topAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: viewBehindScratchCard.bottomAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: viewBehindScratchCard.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: viewBehindScratchCard.trailingAnchor).isActive = true
        
        resetButton.topAnchor.constraint(equalTo: viewBehindScratchCard.bottomAnchor, constant: 40).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        resetButton.widthAnchor.constraint(equalTo: viewBehindScratchCard.widthAnchor, constant: -40).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: viewBehindScratchCard.centerXAnchor).isActive = true
        
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressLabel)
        progressLabel.textAlignment = .center
        progressLabel.textColor = .white
        progressLabel.font = UIFont.systemFont(ofSize: 30)
        
        progressLabel.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20).isActive = true
        progressLabel.leadingAnchor.constraint(equalTo: viewBehindScratchCard.leadingAnchor, constant: 20).isActive = true
        progressLabel.trailingAnchor.constraint(equalTo: viewBehindScratchCard.trailingAnchor, constant: -20).isActive = true
        progressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    @objc func handleReserButton() {
        previewView.reset()
        progressLabel.text = String.init(format: "-- %d %@ --", 0 , "%")
    }
    
    func scratch(percentage value: Int) {
        progressLabel.text = String.init(format: "-- %d %@ --", value , "%")
    }
    
}
