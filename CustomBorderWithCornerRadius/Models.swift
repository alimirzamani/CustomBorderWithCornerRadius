//
//  Models.swift
//  CustomBorderWithCornerRadius
//
//  Created by Ali Mirzamani on 5/29/21.
//

import UIKit

struct CornerRadius {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat
}

struct Border {
    var width: CGFloat
    var color: UIColor
    var edges: UIRectEdge = .all
}
