//
//  ScratchCardView.swift
//  ScratchCardDemo
//
//  Created by Khaled Rahman Ayon on 18.02.20.
//  Copyright © 2020 Khaled Rahman Ayon. All rights reserved.
//


import UIKit

class ScratchCardView: UIView {
    
    var startPoint:CGPoint!
    var endPoint:CGPoint!
    var context:CGContext!
    var co_ordinates = [(startPoint:CGPoint,endPoint:CGPoint)]()
    var swiped = false
    
    
    func reset() {
        
        co_ordinates.removeAll()
        min_x = 1000
        max_x = 0
        min_y = 1000
        max_y = 0
        self.setNeedsDisplay()
    }
    
    var min_x:Int = 1000
    var max_x:Int = 0
    
    var min_y:Int = 1000
    var max_y:Int = 0
//    var scratchImage: UIImage?
    
    var overlayImage:UIImage!

    override func draw(_ rect: CGRect) {
        super.draw(rect)
                
//        guard let image = scratchImage
//            else {
//                fatalError("PLEASE ADD ADD SCRATCH IMAGE")
//        }
        
        overlayImage = UIImage(named: "test")
        overlayImage.draw(in: self.frame)
        
        context = UIGraphicsGetCurrentContext()
        
        for each in co_ordinates {
            
            self.drawLineFrom(fromPoint:each.startPoint , toPoint: each.endPoint)
            
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startPoint = touches.first?.location(in: self)
        
        storeStartCoordiante()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            co_ordinates.append((self.startPoint,self.startPoint))
            setNeedsDisplay()
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.endPoint = touches.first?.location(in: self)
        
        guard  self.frame.contains(self.endPoint)
            else {
                return
        }
        
        storeEndCoordinate()
        
        swiped = true
        co_ordinates.append((self.startPoint,self.endPoint))
        
        self.startPoint = endPoint
        
        setNeedsDisplay()
        
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
