//
//  SpinnerView.swift
//  Spinner
//
//  Created by Karan Gavali on 16/12/17.
//  Copyright © 2017 Karan Gavali. All rights reserved.
//

import UIKit

class SpinnerView: UIView {
    
    private var scaleLayer = CAShapeLayer()
    private var shapeLayer = CAShapeLayer()
    private var bezierPath: UIBezierPath!
    
    
    override func draw(_ rect: CGRect) {
        scaleCircle()
        super.draw(rect)
    }
    
    func scaleCircle() {
        bezierPath = UIBezierPath(arcCenter: .zero, radius: self.frame.size.width / 2, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        scaleLayer.fillColor = UIColor.red.cgColor
        scaleLayer.strokeColor = UIColor.red.cgColor
        scaleLayer.lineWidth = 2
        scaleLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.width / 2)
        scaleLayer.path = bezierPath.cgPath
        layer.addSublayer(scaleLayer)
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.width / 2)
        shapeLayer.path = bezierPath.cgPath
        layer.insertSublayer(shapeLayer, above: scaleLayer)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.5
        animation.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
        animation.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        scaleLayer.add(animation, forKey: "scale")
        
        CATransaction.setCompletionBlock({
            self.scaleLayer.removeAllAnimations()
            self.scaleLayer.removeFromSuperlayer()
            self.shapeLayer.fillColor = UIColor.clear.cgColor
            self.animateCircle()
        })
        
        CATransaction.begin()
        let animation1 = CABasicAnimation(keyPath: "transform.scale")
        animation1.duration = 1
        animation1.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
        animation1.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        shapeLayer.add(animation1, forKey: "scaleSecond")
        CATransaction.commit()
    }
    
    private func animateCircle() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = CGFloat.pi * 2
        rotate.duration = 2
        rotate.repeatCount = .infinity
        
        shapeLayer.strokeEnd = 1
        
        shapeLayer.add(animation, forKey: "animation")
        shapeLayer.add(rotate, forKey: "rotate")
        
    }
}
