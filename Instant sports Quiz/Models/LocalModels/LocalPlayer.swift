//
//  LocalPlayer.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/8/22.
//

import Foundation

class LocalPlayer{
    var name:String?
    var points:Int?
    
    init(name:String,points:Int){
        self.name = name
        self.points = points
    }
    
    static func getTopPlayers() -> [LocalPlayer]{
        let names = ["John","Peter","George","Mary","Leo","Mathew","Jacob","Elza","Sara","Jude","Luke"]
        let points = [1230,980,960,860,830,810,790,780,740,650,600]
        var players = [LocalPlayer]()
        for i in 0...names.count-1{
            let player = LocalPlayer(name: names[i], points: points[i])
            players.append(player)
        }
        
        return players
    }
    
    static func getPlayers(limit:Int) -> [LocalPlayer]?{
        var players = [LocalPlayer]()
        if limit > getTopPlayers().count{
            return nil
        }
        for i in 0...limit-1{
            players.append(getTopPlayers()[i])
        }
        return players
    }
}
