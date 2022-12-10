//
//  QuestionsViewModel.swift
//  Instant sports Quiz
//
//  Created by Remya on 12/9/22.
//

import Foundation

protocol QuestionsViewModelDelegate{
    func didFinishFetchPlayers()
}

class QuestionsViewModel{
    var delegate:QuestionsViewModelDelegate?
    var playerData:LineupList?
    var players = [Lineup]()
    
    func getPlayers(){
        HomeAPI().getLinup { response in
            self.playerData = response.lineupList?.first
            self.setupModel()
            self.delegate?.didFinishFetchPlayers()
            
        } failed: { _ in
            
        }

    }
    
    func setupModel(){
        self.players.append(contentsOf: self.playerData?.awayLineup ?? [])
        self.players.append(contentsOf: self.playerData?.homeLineup ?? [])
        self.players.append(contentsOf: self.playerData?.homeBackup ?? [])
        self.players.append(contentsOf: self.playerData?.awayBackup ?? [])
        self.players = self.players.filter{ isCompletePlayer(obj: $0) }
        
    }
    
    func isCompletePlayer(obj:Lineup) -> Bool{
        if obj.playerNameEn?.count ?? 0 > 0 && obj.playerPhoto?.count ?? 0 > 0 && obj.playerBirthday?.count ?? 0 > 0 && obj.playerCountry?.count ?? 0 > 0 {
            return true
        }
        else{
            return false
        }
    }
    
    func getOptions(index:Int) -> [String]{
        var options = [String]()
        var limit1 = 0
        var limit2 = 0
        if index <= players.count - 4{
            limit1 = index
            limit2 = index + 3
        }
        else{
            limit1 = index - 3
            limit2 = index
        }
       
            for i in limit1...limit2{
               // print("Get i Value..\(i)")
                
                if i < players.count{
                    if Utility.getCurrentLang() == "cn"{
                        options.append(players[i].playerNameChs ?? "")
                    }
                    else{
                        options.append(players[i].playerNameEn ?? "")
                    }
                }
            }
        return options.shuffled()
        
    }
    
}

