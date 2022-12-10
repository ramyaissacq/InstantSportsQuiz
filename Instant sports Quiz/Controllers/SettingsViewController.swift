//
//  SettingsViewController.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/10/22.
//

import UIKit
import MessageUI
import MOLH

class SettingsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgEn: UIImageView!
    @IBOutlet weak var imgCn: UIImageView!
    
    //Variables
    var menus = ["Share".localized,"Privacy Policy".localized,"Feedback".localized,"Rate Us".localized]
    var lang = Utility.getCurrentLang()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    
    func initialSettings(){
        self.navigationItem.titleView = getHeaderLabel(title: "Settings".localized)
        setBackButton()
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        resetViews()
        
       
    }
    
    
    @IBAction func actionTapEnglish(_ sender: UITapGestureRecognizer) {
        lang = "en"
        resetViews()
        resetLanguage()
        
    }
    
    
    @IBAction func actionTapChinese(_ sender: UITapGestureRecognizer) {
        lang = "zh-Hans"
        resetViews()
        resetLanguage()
    }
    
    

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["remakereduce@gmail.com"])
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            Utility.showErrorSnackView(message: "Mail is not configured on the device")
            // show failure alert
        }
    }
    
    func resetLanguage(){
       // KickOffViewController.fromLanguage = true
        MOLHLanguage.setAppleLAnguageTo(lang)
        MOLH.reset()
    }
    
    func resetViews(){
        if lang == "en"{
            imgEn.image = UIImage(named: "RadioS")
            imgCn.image = UIImage(named: "Radio")
        }
        else{
            imgEn.image = UIImage(named: "Radio")
            imgCn.image = UIImage(named: "RadioS")
            
        }
    }
   

}


extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTableViewCell
        cell.imgIcon.image = UIImage(named: "menu\(indexPath.row)")
        cell.lblTitle.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            Utility.shareAction(text: "Install Instant Sports Quiz from apple appstore", url: URL(string: ""), image: UIImage(named: "launch"), vc: self.parent!)
        case 1:
            Utility.openUrl(url: URL(string: "")!)
        case 2:
            sendEmail()
            
        case 3:
            Utility.rateApp(id: "")
        default:
            break
        }
    }
    
    
}


extension SettingsViewController:MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
