//
//  MainVC.swift
//  ScratchCardDemo
//
//  Created by Khaled Rahman Ayon on 18.02.20.
//  Copyright © 2020 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
       let viewBehindScratchCard = UIView()
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
        
        let previewView = ScratchCardView()
        previewView.backgroundColor = .clear
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.isUserInteractionEnabled = true
        viewBehindScratchCard.addSubview(previewView)
        
        previewView.topAnchor.constraint(equalTo: viewBehindScratchCard.topAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: viewBehindScratchCard.bottomAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: viewBehindScratchCard.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: viewBehindScratchCard.trailingAnchor).isActive = true

    }
    
}
