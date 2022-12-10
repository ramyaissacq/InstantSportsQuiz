//
//  RankTableViewCell.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/10/22.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRank: UILabel!
    
    @IBOutlet weak var imgPlayer: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPoints: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:LocalPlayer,index:Int){
        lblName.text = obj.name
        lblPoints.text = "\(obj.points ?? 0)"
        lblRank.text = "\(index)"
        
    }
    
}
