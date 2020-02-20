//
//  MainVC.swift
//  ScratchCardDemo
//
//  Created by Khaled Rahman Ayon on 18.02.20.
//  Copyright © 2020 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let viewBehindScratchCard = ScratchCardContainerView()
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        viewBehindScratchCard.isUserInteractionEnabled = true
        viewBehindScratchCard.backgroundColor = .clear
        
        viewBehindScratchCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewBehindScratchCard)
        
        viewBehindScratchCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewBehindScratchCard.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewBehindScratchCard.widthAnchor.constraint(equalToConstant: 400).isActive = true
        viewBehindScratchCard.heightAnchor.constraint(equalToConstant: 320).isActive = true
    }
}
