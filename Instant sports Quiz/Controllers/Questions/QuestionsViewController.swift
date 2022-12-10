//
//  QuestionsViewController.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/8/22.
//

import UIKit
import Lottie

class QuestionsViewController: BaseViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblIndex: UILabel!
    
    //Variables
    let viewModel = QuestionsViewModel()
    var currentPlayer:Lineup?
    var options = [String]()
    var index = 0
    var points = 0
    var selectedIndex:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionConfirm(_ sender: Any) {
        if selectedIndex == nil{
            return
        }
        index += 1
        if index < viewModel.players.count{
        
        lblIndex.text = "\(index + 1)"
            var playerName = ""
            if Utility.getCurrentLang() == "cn"{
                playerName = currentPlayer?.playerNameChs ?? ""
            }
            else{
                playerName = currentPlayer?.playerNameEn ?? ""
            }
            if options[selectedIndex!] == playerName{
              points += 10
                print(points)
            }
        currentPlayer = viewModel.players[index]
        options = viewModel.getOptions(index: index)
        tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThanksViewController") as! ThanksViewController
            vc.points = points
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func initialSettings(){
        self.navigationItem.titleView = getHeaderLabel(title: "QUIZ".localized)
        setBackButton()
        configureLottieAnimation()
        tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "Qcell")
        tableView.register(UINib(nibName: "OptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "Optcell")
        viewModel.delegate = self
        viewModel.getPlayers()
    }
    
    func configureLottieAnimation(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        
    }
    

}


extension QuestionsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let Qcell = tableView.dequeueReusableCell(withIdentifier: "Qcell") as! QuestionTableViewCell
            if currentPlayer != nil{
            Qcell.configureCell(obj: currentPlayer!)
            }
            return Qcell
        }
        else{
            let Optcell = tableView.dequeueReusableCell(withIdentifier: "Optcell") as! OptionsTableViewCell
            if options.count > 0{
            Optcell.lblPlayer.text = options[indexPath.row - 1]
            }
            return Optcell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0{
            selectedIndex = indexPath.row - 1
        }
    }
    
    
}


extension QuestionsViewController:QuestionsViewModelDelegate{
    func didFinishFetchPlayers() {
        currentPlayer = viewModel.players.first
        options = viewModel.getOptions(index: index)
        tableView.reloadData()
        if viewModel.players.count > 0{
            animationView.stop()
            emptyView.isHidden = true
        }
        else{
            animationView.play()
            emptyView.isHidden = false
        }
    }
    
    
}
