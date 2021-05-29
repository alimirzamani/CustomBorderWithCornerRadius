//
//  ViewController.swift
//  CustomBorderWithCornerRadius
//
//  Created by Ali Mirzamani on 5/26/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.myView.backgroundColor = .clear
            self.myView.borderWithCornerRadius(corner: CornerRadius(corners: [.allCorners], radius: 10), border: Border(width: 1, color: .blue, edges: [.top, .bottom]))
        }
    }
}
