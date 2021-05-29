//
//  UIView+Extension.swift
//  CustomBorderWithCornerRadius
//
//  Created by Ali Mirzamani on 5/29/21.
//

import UIKit

extension UIView {
    func borderWithCornerRadius(corner: CornerRadius? = nil, border: Border? = nil) {
        if let corner = corner {
            setupCornerRadius(corner: corner)
        }
        
        if let border = border {
            setupBorder(corner: corner, borderConfig: border)
        }
    }
    
    private func setupCornerRadius(corner: CornerRadius) {
        let corners = corner.corners
        self.clipsToBounds = true
        self.layer.cornerRadius = corner.radius
        
        var masked = CACornerMask()
        if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
        if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
        if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
        if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
        self.layer.maskedCorners = masked
    }
    
    private func setupBorder(corner: CornerRadius? = nil, borderConfig: Border) {
        let layerName = "pathBorderLayer"
        
        self.layer.sublayers?.forEach({ subLayer in
            if subLayer.name == layerName {
                subLayer.removeFromSuperlayer()
            }
        })
        
        let border = CAShapeLayer()
        border.name = layerName
        border.path = createPath(corners: corner?.corners ?? .allCorners, cornerRadius: corner?.radius ?? 0, edges: borderConfig.edges).cgPath
        
        border.strokeColor = borderConfig.color.cgColor
        border.fillColor = UIColor.clear.cgColor
        border.lineWidth = borderConfig.width
        self.layer.addSublayer(border)
    }
    
    func createPath(corners: UIRectCorner, cornerRadius: CGFloat, edges: UIRectEdge) -> UIBezierPath {
        let path = UIBezierPath()
        
        let topLeftCornerRadius = (corners.contains(.topLeft)) ? cornerRadius : 0
        let topRightCornerRadius = (corners.contains(.topRight)) ? cornerRadius : 0
        let bottomRightCornerRadius = (corners.contains(.bottomRight)) ? cornerRadius : 0
        let bottomLeftCornerRadius = (corners.contains(.bottomLeft)) ? cornerRadius : 0
        
        // Top
        if edges.contains(.all) || edges.contains(.top) {
            path.move(to: CGPoint(x: 0, y: topLeftCornerRadius))
            path.addArc(withCenter: CGPoint(x: topLeftCornerRadius, y: topLeftCornerRadius), radius: topLeftCornerRadius, startAngle: .pi, endAngle: 3*(.pi/2), clockwise: true)
            path.addLine(to: CGPoint(x: self.bounds.width-topLeftCornerRadius, y: 0))
            
            
            path.addArc(withCenter: CGPoint(x: self.bounds.width-topRightCornerRadius, y: topRightCornerRadius), radius: topRightCornerRadius, startAngle: 3*(.pi/2), endAngle: 0, clockwise: true)
        }
        
        // Right
        if edges.contains(.all) || edges.contains(.right) {
            path.move(to: CGPoint(x: self.bounds.width, y: topRightCornerRadius))
            path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height-bottomRightCornerRadius))
        }
        
        // Bottom
        if edges.contains(.all) || edges.contains(.bottom) {
            
            path.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height-bottomRightCornerRadius))
            path.addArc(withCenter: CGPoint(x: self.bounds.width-bottomRightCornerRadius, y: self.bounds.height-bottomRightCornerRadius), radius: bottomRightCornerRadius, startAngle: 0, endAngle: .pi/2, clockwise: true)
            path.addLine(to: CGPoint(x: bottomRightCornerRadius, y: self.bounds.height))
            
            
            path.addArc(withCenter: CGPoint(x: bottomLeftCornerRadius, y: self.bounds.height-bottomLeftCornerRadius), radius: bottomLeftCornerRadius, startAngle: .pi/2, endAngle: .pi, clockwise: true)
        }
        
        // Left
        if edges.contains(.all) || edges.contains(.left) {
            path.move(to: CGPoint(x: 0, y: self.bounds.height-bottomLeftCornerRadius))
            path.addLine(to: CGPoint(x: 0, y: topLeftCornerRadius))
        }
        return path
    }
}
