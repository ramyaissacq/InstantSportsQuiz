//
//  RankingViewController.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/10/22.
//

import UIKit

class RankingViewController: BaseViewController {

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableViewRankings: UITableView!
    
    //Variables
    var topPlayers = LocalPlayer.getTopPlayers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    func initialSettings(){
        self.navigationItem.titleView = getHeaderLabel(title: "Ranking".localized)
        setBackButton()
        tableViewRankings.register(UINib(nibName: "RankTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
  

}


extension RankingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RankTableViewCell
        cell.configureCell(obj: topPlayers[indexPath.row], index: indexPath.row+1)
        return cell
    }
    
    
}


extension RankingViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
    }
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trim() != ""{
//            if let obj = KickOffViewController.urlDetails?.mapping?.filter({$0.keyword?.lowercased() == searchText.lowercased()}).first{
//                AppPreferences.setMapObject(obj: obj)
//                if obj.openType == "0"{
//                    AppPreferences.setIsSearched(value: true)
//                    gotoWebview(url: obj.redirectUrl ?? "")
//                }
//                else{
//                    AppPreferences.setIsSearched(value: false)
//                    guard let url = URL(string: obj.redirectUrl ?? "") else {return}
//                    Utility.openUrl(url: url)
//                    clearSearch()
//                }
//
//            }
//
//            else{
            doSearch(searchText: searchText)
           // }
        }
        else{
            
            self.topPlayers = LocalPlayer.getTopPlayers()
            
            self.tableViewRankings.reloadData()
            
        }
        
    }
    
    func doSearch(searchText:String){
        let originals = LocalPlayer.getPlayers(limit: 4)
        topPlayers = originals!.filter{$0.name?.contains(searchText) ?? false}
        tableViewRankings.reloadData()
        
    }
    
    func gotoWebview(url:String){
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        if url != ""{
            vc.urlString = url
        }
        self.navigationController?.pushViewController(vc, animated: true)
        clearSearch()
        
    }
    
    func clearSearch(){
        searchbar.text = ""
        searchbar.endEditing(true)
        self.topPlayers = LocalPlayer.getTopPlayers()
        self.tableViewRankings.reloadData()
    }
    
}
