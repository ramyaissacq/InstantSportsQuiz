//
//  QuestionTableViewCell.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/8/22.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var fixedHeight: UILabel!
    @IBOutlet weak var fixedWeight: UILabel!
    @IBOutlet weak var fixedCountry: UILabel!
    @IBOutlet weak var fixedBirthday: UILabel!
    
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fixedHeight.text = "Height:".localized
        fixedWeight.text = "Weight:".localized
        fixedCountry.text = "Country:".localized
        fixedBirthday.text = "Birthday:".localized
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
