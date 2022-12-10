//
//  PlayerCollectionViewCell.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/8/22.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblPoints:UILabel!
    @IBOutlet weak var leftView:UIView!
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var rightView:UIView!

    @IBOutlet weak var lblRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        backView.roundCorners(corners: [.topRight,.bottomLeft,.bottomRight],radius: 20)
        leftView.roundCorners(corners: [.bottomLeft],radius: 20)
        rightView.roundCorners(corners: [.topRight,.bottomRight],radius: 20)
        
    }
    
    func configureCell(obj:LocalPlayer,index:Int){
        lblName.text = obj.name
        lblPoints.text = "\(obj.points ?? 0)"
        lblRank.text = "\(index)"
        
    }

}
