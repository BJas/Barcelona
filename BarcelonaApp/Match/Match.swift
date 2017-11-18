//
//  Match.swift
//  BarcelonaApp
//
//  Created by Apple on 18.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Match {
    var matchday: Int
    var competation: String
    var date: String
    var status: String
    var homeTeam: String
    var awayTeam: String
    var homeGoal: Int
    var awayGoal: Int
    var homeImg: String
    var awayImg: String
    init(matchday: Int, competation: String, date: String, status: String, homeTeam: String, awayTeam: String, homeGoal: Int, awayGoal: Int, homeImg: String, awayImg: String){
        self.matchday = matchday
        self.competation = competation
        self.date = date
        self.status = status
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeGoal = homeGoal
        self.awayGoal = awayGoal
        self.homeImg = homeImg
        self.awayImg = awayImg
    }
    
    static func form(matchday: Int, competation: String, date: String, status: String, homeTeam: String, awayTeam: String, homeGoal: Int, awayGoal: Int, homeImg: String, awayImg: String) ->
        Match{
            let result = Match(matchday: matchday, competation: competation, date: date, status: status, homeTeam: homeTeam, awayTeam: awayTeam, homeGoal: homeGoal, awayGoal: awayGoal, homeImg: homeImg, awayImg: awayImg)
            
            return result
    }
}
