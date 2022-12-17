//
//  AppDelegate.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/7/22.
//

import UIKit
import IQKeyboardManagerSwift
import MOLH

@main
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    var window:UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if AppPreferences.getLaunchDate().count == 0{
            AppPreferences.setLaunchDate(date: "16-12-2022")
        }
        IQKeyboardManager.shared.enable = true
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
        setRoot()
        return true
    }

    func setRoot(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaunchesViewController")
        window?.rootViewController = vc
        
    }
    
    func reset() {
        
        setupLaunch()
    }
    
    func setupLaunch(){
        //if AppPreferences.getIsFirstRun(){
            Utility.gotoHome()
            if Utility.getSettingsDateDiff() >= 4{
            Utility.callURlDetailsAPI()
            }
           
//        }
//        else{
//            AppPreferences.setIsFirstRun(value: true)
//            let initVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController")
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = initVC
//        }
        
    }
    
   
    func getPhoneLanguage() -> String{
        var locale = NSLocale.current.languageCode!
        let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? ""
        if countryCode == "CN"{
            locale = "zh"
        }
        return locale
        
    }

}

