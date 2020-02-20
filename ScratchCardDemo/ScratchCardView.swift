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
    var scratchDelegate:ScratchCardDelegate?
    
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
        scratchCardImage.draw(in: self.frame)
        context = UIGraphicsGetCurrentContext()
        
        for point in co_ordinates {
            self.drawLineFrom(fromPoint:point.startPoint , toPoint: point.endPoint)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.startPoint = touches.first?.location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.endPoint = touches.first?.location(in: self)
        
        guard self.frame.contains(self.endPoint) else { return }
        
        co_ordinates.append((self.startPoint,self.endPoint))
        
        self.startPoint = endPoint
        
        setNeedsDisplay()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(getTransparentPixelsPercent())
        let scratchPecennt = Int(getTransparentPixelsPercent() * 100)
        scratchDelegate?.scratch(percentage: scratchPecennt)
    }
    
    fileprivate func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        context.setLineWidth(40)
        context.move(to: fromPoint)
        context.setBlendMode(.clear)
        context.setLineCap(.square)
        context.addLine(to: toPoint)
        context.strokePath()
    }
}

extension ScratchCardView {
    func reset() {
        co_ordinates.removeAll()
        self.setNeedsDisplay()
    }
}

extension UIView {
    
    func getSnapshot() -> CGImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.cgImage
    }
    
    func getTransparentPixelsPercent() -> Double {
        guard let image = getSnapshot(), let imageData = image.dataProvider?.data else {
            return 0.0
        }
        
        let width = image.width
        let height = image.height
        let imageDataPointer: UnsafePointer<UInt8> = CFDataGetBytePtr(imageData)
        var transparentPixelCount = 0
        
        for x in 0...width {
            for y in 0...height {
                let pixelDataPosition = ((width * y) + x) * 2
                // The alpha value is the last 8 bits of the data
                let alphaValue = imageDataPointer[pixelDataPosition + 3]
                if alphaValue == 0 {
                    transparentPixelCount += 1
                }
            }
        }
        
        var transparentPercent = Double(transparentPixelCount) / Double((width * height))
        transparentPercent = max(transparentPercent, 0)
        transparentPercent = min(transparentPercent, 1)
        return transparentPercent
    }
}

