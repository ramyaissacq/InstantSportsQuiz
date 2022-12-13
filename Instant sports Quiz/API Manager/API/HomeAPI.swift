//
//  HomeAPI.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import Foundation
import SwiftyJSON

class HomeAPI: WebService {
   
    
    
    
    func getUrlInfo(completion:@escaping (UrlDetails) -> Void, failed: @escaping (String) -> Void){
        //https://app.8com.cloud/api/v1/setting.php
        //https://app.8com.cloud/api/v1/setting
        let url = "https://b.886811.fun/api/v1/setting.php"
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        let build = Bundle.main.infoDictionary!["CFBundleVersion"]!
        //"com.test.app",
        //"test2",
        let params:[String:Any] = ["package_name":"test",//Bundle.main.bundleIdentifier ?? "",
            "platform":"iOS",
            "device_name":UIDevice.current.model,
            "version":version,
            "build_number":build]
        
        post(url: url, params: params, completion: { json in
           let response = UrlDetails(json!)
            completion(response)
        }, failed: failed)

    }
    
    
    
    func getLinup(completion:@escaping (LinupResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.linup.rawValue
        get(url: url, params: [:], completion: { json in
            let response = LinupResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
   
}
