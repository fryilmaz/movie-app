//
//  TitleLabel.swift
//  MovieApp
//
//  Created by Faruk on 8.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    override func draw(_ rect: CGRect) {
        let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by:inset))
    
    }
}
