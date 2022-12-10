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
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
        //setRoot()
        return true
    }

    func setRoot(){
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "LaunchesViewController")
        window?.rootViewController = vc
        
    }
    
    func reset() {
        
        setupLaunch()
    }
    
    func setupLaunch(){
       // if AppPreferences.getIsFirstRun(){
            Utility.gotoHome()
            Utility.callURlDetailsAPI()
           
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

