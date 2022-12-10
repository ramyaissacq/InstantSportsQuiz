//
//  HomeViewController.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/7/22.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblPts: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    
    var topPlayers = LocalPlayer.getPlayers(limit: 4)
    var topView = PointsView(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    override func viewWillLayoutSubviews() {
        collectionView.reloadData()
    }
    
    func initialSettings(){
        collectionView.registerCell(identifier: "PlayerCollectionViewCell")
        setupNavigationBar()
       
    }
    
    func setupNavigationBar(){
        let leftBtn1 = getButton(image: UIImage(named: "home")!)
//        let leftBtn2 = getButton(image: UIImage(named: "leader")!)
//        leftBtn2.addTarget(self, action: #selector(openLeaderboard), for: .touchUpInside)
        //,UIBarButtonItem(customView: leftBtn2)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: leftBtn1)]
        let img = UIImageView(image: UIImage(named: "quiz"))
        self.navigationItem.titleView = img
        let rightBtn1 = getButton(image: UIImage(named: "setting")!)
        rightBtn1.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightBtn1),UIBarButtonItem(customView: topView)]
    }
    
    @objc func openLeaderboard(){
        
    }

    @objc func openSettings(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func actionStart(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}


extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topPlayers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as! PlayerCollectionViewCell
        if let obj = topPlayers?[indexPath.row]{
        cell.configureCell(obj: obj, index: indexPath.row+1)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing:CGFloat = 260+60
        let sp = (UIScreen.main.bounds.width - spacing) / 2
        return UIEdgeInsets(top: 0, left: sp, bottom: 0, right: sp)
    }
    
    
    
}


extension HomeViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.searchBar.endEditing(true)
        
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        searchBar.endEditing(true)
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.trim() != ""{
////            if let obj = KickOffViewController.urlDetails?.mapping?.filter({$0.keyword?.lowercased() == searchText.lowercased()}).first{
////                AppPreferences.setMapObject(obj: obj)
////                if obj.openType == "0"{
////                    AppPreferences.setIsSearched(value: true)
////                    gotoWebview(url: obj.redirectUrl ?? "")
////                }
////                else{
////                    AppPreferences.setIsSearched(value: false)
////                    guard let url = URL(string: obj.redirectUrl ?? "") else {return}
////                    Utility.openUrl(url: url)
////                    clearSearch()
////                }
////
////            }
////
////            else{
//            doSearch(searchText: searchText)
//           // }
//        }
//        else{
//
//            self.topPlayers = LocalPlayer.getPlayers(limit: 4)
//
//            self.collectionView.reloadData()
//
//        }
//
//    }
    
    func doSearch(searchText:String){
        let originals = LocalPlayer.getPlayers(limit: 4)
        topPlayers = originals!.filter{$0.name?.contains(searchText) ?? false}
        collectionView.reloadData()
        
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
        searchBar.text = ""
        searchBar.endEditing(true)
        self.topPlayers = LocalPlayer.getPlayers(limit: 4)
        self.collectionView.reloadData()
    }
    
}

