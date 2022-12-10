//
//  OptionsTableViewCell.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/8/22.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var lblPlayer: UILabel!
    @IBOutlet weak var centreView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //let gradient = centreView.getGradientLayer(bounds: centreView.bounds,color1: Colors.lineGradient1Color().cgColor,color2: Colors.lineGradient2Color().cgColor)
        centreView.borderColor = UIColor(named: "lineGradient2") //centreView.gradientColor(bounds: centreView.bounds, gradientLayer: gradient)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            blueView.backgroundColor = Colors.accentColor()
        }
        else{
            blueView.backgroundColor = Colors.violetColor()
        }

        // Configure the view for the selected state
    }
    
}
