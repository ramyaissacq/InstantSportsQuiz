

import UIKit
import SwiftyJSON

class AppPreferences {
    private enum Keys : String {
        
        case APPLE_LANGUAGE_KEY = "AppleLanguages"
        case IsFirstRun = "IsFirstRun"
        case popupFrequency = "popupFrequency"
        case mapData = "mapData"
         case isSearched = "isSearched"
        
        
    }
    
    class func setIsSearched(value: Bool)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: Keys.isSearched.rawValue)
    }
    
    class func getIsSearched() -> Bool
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.bool(forKey: Keys.isSearched.rawValue)
        
        return value
        
    }
    
    
    class func setMapObject(obj:Mapping){
        
     let userDefaults = UserDefaults.standard
     userDefaults.set(obj.toDictionary(), forKey: Keys.mapData.rawValue)
        
         }
    
   
       class func getMapObject() -> Mapping?{
           let userDefaults = UserDefaults.standard
           if let mapData = userDefaults.object(forKey: Keys.mapData.rawValue) as? [String:Any]
           {
               let mapDataModel = Mapping.init(JSON(mapData))
               return mapDataModel
           }
           return nil
       }
    
  
    
    
    
    class func setIsFirstRun(value: Bool)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: Keys.IsFirstRun.rawValue)
    }
    
    class func getIsFirstRun() -> Bool
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.bool(forKey: Keys.IsFirstRun.rawValue)
        
        return value
        
    }
    
    class func setPopupFrequency(frequency: Int)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(frequency, forKey: Keys.popupFrequency.rawValue)
    }
    
    class func getPopupFrequency() -> Int
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.integer(forKey: Keys.popupFrequency.rawValue)
        
        return value
        
    }
    
    
    
    //    class func setToken(withToken token: String)
    //    {
    //        let userDefaults = UserDefaults.standard
    //        userDefaults.setValue(token, forKey: Keys.token.rawValue)
    //    }
    //
    //    class func getToken() -> String
    //    {
    //        let userDefaults = UserDefaults.standard
    //        if let token = userDefaults.string(forKey: Keys.token.rawValue)
    //        {
    //            return token
    //        }
    //        return ""
    //    }
    //
    //
    //
    //    class func setUserData(withUserData userData : User){
    //        let userDefaults = UserDefaults.standard
    //        userDefaults.set(userData.toDictionary(), forKey: Keys.userData.rawValue)
    //    }
    //
    //    class func getUserData() -> User{
    //        let userDefaults = UserDefaults.standard
    //        if let userData = userDefaults.object(forKey: Keys.userData.rawValue) as? [String:Any]
    //        {
    //            let userDataModel = User.init(fromJson: JSON(userData))
    //            return userDataModel
    //        }
    //        return User()
    //    }
    //
    //    class func clearPreferences(clear: @escaping () -> Void)
    //    {
    //        let defaults = UserDefaults.standard
    //        let dictionary = defaults.dictionaryRepresentation()
    //        dictionary.keys.forEach { key in
    //            if(key != Keys.APPLE_LANGUAGE_KEY.rawValue)
    //            {
    //                defaults.removeObject(forKey: key)
    //            }
    //        }
    //        clear()
    //    }
}
