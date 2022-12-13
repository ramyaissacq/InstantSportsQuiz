//
//  HomeViewController.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/7/22.
//

import UIKit
import ImageSlideshow
class HomeViewController: BaseViewController {
    
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblPts: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var imageSlideshow:ImageSlideshow!
    
    let pageIndicator = UIPageControl()
    var topPlayers = LocalPlayer.getPlayers(limit: 4)
    var topView = PointsView(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
    static var urlDetails:UrlDetails?
    static var popupFlag = 1
    static var timer = Timer()
    static var fromLanguage = false
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    override func viewWillLayoutSubviews() {
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeViewController.popupFlag = 1
        setupLeftView()
        setupPoints()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        HomeViewController.popupFlag = 0
    }
    
    @IBAction func actionStart(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @objc func appWillEnterForeground() {
        HomeViewController.popupFlag = 1
        setupLeftView()
    }
    
    func initialSettings(){
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSlides), name: Notification.Name("RefreshSlideshow"), object: nil)
        collectionView.registerCell(identifier: "PlayerCollectionViewCell")
        setupNavigationBar()
        
    }
    
    @objc func refreshSlides(){
        if HomeViewController.urlDetails?.mapping?.count ?? 0 > 0{
            setupSlideshow()
        }
       
    }
    
    func setupPoints(){
        let points = AppPreferences.getPoints()
        lblPts.text = "\(points)"
        if points > 0 {
            lblRank.text = "35/100"
        }
    }
    
    func setupLeftView(){
        
        let leftBtn1 = getButton(image: UIImage(named: "home")!)
        if AppPreferences.getMapObject() != nil{
            let btn = getButton(image: UIImage(named: "next")!)
            let gradient = btn.getGradientLayer(bounds: btn.bounds)
            btn.backgroundColor = btn.gradientColor(bounds: btn.bounds, gradientLayer: gradient)
            btn.addTarget(self, action: #selector(specialButtonAction), for: .touchUpInside)
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btn),UIBarButtonItem(customView:  leftBtn1)]
        }
        else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:  leftBtn1)
        }
       
    }
    
    @objc func specialButtonAction() {
        if AppPreferences.getMapObject()?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
            let urlString = AppPreferences.getMapObject()?.redirectUrl ?? ""
        gotoWebview(url: urlString)
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: AppPreferences.getMapObject()?.redirectUrl ?? "") else{return}
                    Utility.openUrl(url: url)
        }
        
    }
    
    func setupNavigationBar(){
        
        setupLeftView()
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
    
    static func configureTimer(){
        if HomeViewController.urlDetails?.prompt?.repeat_status == 1{
        let time:Double = Double(HomeViewController.urlDetails?.prompt?.repeat_time ?? 0)
       timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc static func timerAction(){
        if HomeViewController.urlDetails?.prompt?.repeat_status == 1{
        HomeViewController.openPrompt()
        }
    }
   
   
    static func showPopup(){
        
        NotificationCenter.default.post(name: Notification.Name("RefreshSlideshow"), object: nil)
        let frequency = AppPreferences.getPopupFrequency()
        if HomeViewController.urlDetails?.prompt?.repeat_status == 1{
         openPrompt()
        
        }
        else{
        let promptFrequency = HomeViewController.urlDetails?.prompt?.frequency ?? 0
        if frequency < promptFrequency{
            openPrompt()
            AppPreferences.setPopupFrequency(frequency: frequency+1)
        }
        }
    }
    
    static func openPrompt(){
        //
        if HomeViewController.fromLanguage{
            HomeViewController.fromLanguage = false
            configureTimer()
            return
        }
        if HomeViewController.popupFlag == 1{
            timer.invalidate()
        let title = HomeViewController.urlDetails?.prompt?.title ?? ""
        let message = HomeViewController.urlDetails?.prompt?.message ?? ""
            let btnText = HomeViewController.urlDetails?.prompt?.button ?? "OK".localized
        Dialog.openSpecialSuccessDialog(buttonLabel: btnText, title: title, msg: message, completed: {}, tapped: {
            configureTimer()
            if HomeViewController.urlDetails?.prompt?.redirect_url?.count ?? 0 > 0{
            var mapObj = Mapping()
            mapObj.openType = HomeViewController.urlDetails?.prompt?.open_type
            mapObj.redirectUrl = HomeViewController.urlDetails?.prompt?.redirect_url
            AppPreferences.setMapObject(obj: mapObj)
            }
            else{
                return
            }
            
            if HomeViewController.urlDetails?.prompt?.open_type == "0"{
                AppPreferences.setIsSearched(value: true)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
                
                    vc.urlString = HomeViewController.urlDetails?.prompt?.redirect_url ?? ""
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                if let nav = appDelegate?.window?.rootViewController as? UINavigationController{
                nav.pushViewController(vc, animated: true)
                }
            }
            else{
                AppPreferences.setIsSearched(value: false)
                guard let url = URL(string: HomeViewController.urlDetails?.prompt?.redirect_url ?? "") else{return}
                Utility.openUrl(url: url)
            }
            
        }, closed: {
            configureTimer()
        })
        }
    }
    
    
    func setupSlideshow(){
       
        pageIndicator.currentPageIndicatorTintColor =  Colors.accentColor()
        pageIndicator.pageIndicatorTintColor = UIColor.black
        pageIndicator.numberOfPages = HomeViewController.urlDetails?.banner?.count ?? 0
        imageSlideshow.pageIndicator = pageIndicator
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.slideshowInterval = 2
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
        if HomeViewController.urlDetails?.banner?.count ?? 0 > 0{
            var images = [InputSource]()
            for m in HomeViewController.urlDetails?.banner ?? []{
                if let src = KingfisherSource(urlString: m.image ?? ""){
                    images.append(src)
                }
            }
            imageSlideshow.setImageInputs(images)
            imageSlideshow.isHidden = false
        }
        else{
            imageSlideshow.isHidden = true
        }
       
    }
    
    
    @objc func didTap(){
        let index = pageIndicator.currentPage
        let banner = HomeViewController.urlDetails?.banner?[index]
        var mapObj = Mapping()
        mapObj.openType = banner?.openType
        mapObj.redirectUrl = banner?.redirectUrl
        AppPreferences.setMapObject(obj: mapObj)
        if banner?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
        gotoWebview(url: banner?.redirectUrl ?? "")
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: banner?.redirectUrl ?? "") else{return}
            Utility.openUrl(url: url)
        }
        
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
////            if let obj = HomeViewController.urlDetails?.mapping?.filter({$0.keyword?.lowercased() == searchText.lowercased()}).first{
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
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

