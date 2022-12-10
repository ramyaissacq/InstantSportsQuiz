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
        lblCoins.text = "\(points)"

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
