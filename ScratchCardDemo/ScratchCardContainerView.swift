//
//  MainScratchView.swift
//  ScratchCardDemo
//
//  Created by Khaled Rahman Ayon on 20.02.20.
//  Copyright © 2020 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class ScratchCardContainerView: UIView, ScratchCardDelegate {

    let scratchCardView = ScratchCardView(image: UIImage(named: "scratchImage")!)
    let progressLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scratchCardView.scratchDelegate = self
        
        let couponView = UIImageView(image: UIImage(named: "coupon"))
        couponView.contentMode = .scaleAspectFit
        couponView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(couponView)
        
        couponView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        couponView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        couponView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        couponView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        scratchCardView.translatesAutoresizingMaskIntoConstraints = false
        scratchCardView.isUserInteractionEnabled = true
        addSubview(scratchCardView)
        
        scratchCardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scratchCardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scratchCardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scratchCardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        progressLabel.textAlignment = .center
        progressLabel.textColor = .white
        progressLabel.font = UIFont.systemFont(ofSize: 30)
        
        progressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        progressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scratch(percentage value: Int) {
        progressLabel.text = String.init(format: "-- %d %@ --", value , "%")
    }
}
