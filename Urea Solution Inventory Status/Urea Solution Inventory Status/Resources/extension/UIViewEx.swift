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
}
