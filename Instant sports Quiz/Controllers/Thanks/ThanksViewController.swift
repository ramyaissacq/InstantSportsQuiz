//
//  ThanksViewController.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/9/22.
//

import UIKit

class ThanksViewController: UIViewController {

    @IBOutlet weak var imgFinish: UIImageView!
    @IBOutlet weak var lblCoins: UILabel!
    
    //Variables
    var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    
    func initialSettings(){
        lblCoins.text = "\(points)"
        if Utility.getCurrentLang() == "cn"{
            imgFinish.image = UIImage(named: "finishCN")
        }
    }
    
    
    @IBAction func actionShare(_ sender: UITapGestureRecognizer) {
        Utility.shareAction(text: "Install Instant Sports Quiz from apple appstore", url: URL(string: ""), image: UIImage(named: "launch"), vc: self.parent!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func gotoQuiz(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController")
        let home = self.navigationController?.viewControllers.first
        self.navigationController?.viewControllers = [home!,vc!]
        
    }
    
    
    @IBAction func gotoHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}
