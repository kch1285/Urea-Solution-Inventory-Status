//
//  UIViewEx.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/01.
//

import UIKit

extension UIView {
    // MARK: 그라디언트 배경 구현
    func setGradient(colors: [CGColor], sx: CGFloat = 1, sy: CGFloat = 0, ex: CGFloat = 0, ey: CGFloat = 1) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: sx, y: sy)
        gradient.endPoint = CGPoint(x: ex, y: ey)
        layer.addSublayer(gradient)
    }
    
    func setRoundedRectangle(radius: CGFloat = 10) {
        layer.cornerRadius = radius
        setShadow(radius: 3, opacity: 0.8, color: UIColor(named: "shadowColor")!)
    }
    
    func setShadow(radius: CGFloat, opacity: Float, color: UIColor, offset: CGSize = CGSize(width: 0, height: 0)) {
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
    }
}
