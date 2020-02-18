//
//  ScratchCardView.swift
//  ScratchCardDemo
//
//  Created by Khaled Rahman Ayon on 18.02.20.
//  Copyright © 2020 Khaled Rahman Ayon. All rights reserved.
//


import UIKit
protocol ScratchCardDelegate {
    func scratch(percentage value:Int)
}

class ScratchCardView: UIView {
    
    var startPoint:CGPoint!
    var endPoint:CGPoint!
    var context:CGContext!
    var co_ordinates = [(startPoint:CGPoint,endPoint:CGPoint)]()
    var swiped = false
    var scratchDelegate:ScratchCardDelegate?

    var min_x:Int = 1000
    var max_x:Int = 0
    
    var min_y:Int = 1000
    var max_y:Int = 0
    
    let scratchCardImage:UIImage
    
    init(image: UIImage) {
        self.scratchCardImage = image
        super.init(frame: .zero)
         backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        calculateUserScratchArea()
        scratchCardImage.draw(in: self.frame)
        context = UIGraphicsGetCurrentContext()
        
        for point in co_ordinates {
            self.drawLineFrom(fromPoint:point.startPoint , toPoint: point.endPoint)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startPoint = touches.first?.location(in: self)
        storeStartCoordiante()
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.endPoint = touches.first?.location(in: self)
        
        
        
        guard self.frame.contains(self.endPoint) else { return }
        
        storeEndCoordinate()
        
        swiped = true
        co_ordinates.append((self.startPoint,self.endPoint))
        
        self.startPoint = endPoint
        
        setNeedsDisplay()
        
    }
    
    fileprivate func calculateUserScratchArea() {

        // Area of rectange = Length * Width
        
        let scratchCardArea =  self.bounds.width*self.bounds.height
        
        let maxLengthOfScratchSurface = (max_y - min_y)
        let maxWidthOfScratchSurface = (max_x - min_x)
        
        let scratchedArea = maxWidthOfScratchSurface * maxLengthOfScratchSurface
        
        guard scratchedArea > 0 else {
            return
        }
        
        let scratchPercentage = ( CGFloat(scratchedArea) / CGFloat(scratchCardArea)  ) * 100
        print(scratchPercentage)
        
        //FIXME: MAKE ME STABLE
        if scratchPercentage < 95 {
            
            scratchDelegate?.scratch(percentage: Int(scratchPercentage))
            
        } else if scratchPercentage < 200  {
            
            scratchDelegate?.scratch(percentage: 100)
        }
        
    }
    fileprivate func storeStartCoordiante() {
        let temp_x = Int(self.startPoint.x)
        let temp_y = Int(self.startPoint.y)
        
        if temp_x<min_x {
            min_x = temp_x
        }
        
        if temp_y<min_y {
            min_y = temp_y
        }
    }
    
    fileprivate func storeEndCoordinate() {
           let temp_x = Int(self.endPoint.x)
           let temp_y = Int(self.endPoint.y)
           
           if temp_x>max_x {
               max_x = temp_x
           }
           if temp_y>max_y {
               max_y = temp_y
           }
           
           if temp_x<min_x  {
               min_x = temp_x
           }
           if temp_y<min_y {
               min_y = temp_y
           }
       }
    
    fileprivate func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        context.setLineWidth(20)
        context.move(to: fromPoint)
        context.setBlendMode(.clear)
        context.setLineCap(.round)
        context.addLine(to: toPoint)
        context.strokePath()
        
    }
}

extension ScratchCardView {
    func reset() {
        co_ordinates.removeAll()
        min_x = 1000
        max_x = 0
        min_y = 1000
        max_y = 0
        self.setNeedsDisplay()
    }
}
