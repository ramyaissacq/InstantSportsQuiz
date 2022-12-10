//
//  QuestionTableViewCell.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/8/22.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:Lineup){
        lblHeight.text = obj.playerHeight
        lblWeight.text = obj.playerWeight
        lblCountry.text = obj.playerCountry
        lblBirthday.text = obj.playerBirthday
        imgPhoto.setImage(with: obj.playerPhoto, placeholder: Utility.getPlaceHolder())
    }
    
    
}
