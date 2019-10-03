//
//  Wave.swift
//  SoundWave
//
//  Created by Charanjit Singh on 27/09/19.
//  Copyright © 2019 Charanjit Singh. All rights reserved.
//

import UIKit

class Wave: UIView {
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    class func initFromNib()->Wave {
        return Bundle.main.loadNibNamed("Wave", owner: self, options: nil)?.first as! Wave
    }
}
