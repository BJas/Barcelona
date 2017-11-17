//
//  TableDetails.swift
//  BarcelonaApp
//
//  Created by Apple on 13.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class StandingDetails {
    var goal : Int
    var goalAgain : Int
    var goalDifference : Int
    var wins : Int
    var draws : Int
    var losses : Int
    
    init(goal : Int, goalAgain: Int, goalDifference: Int, wins : Int, draws : Int, losses : Int){
        self.goal = goal
        self.wins = wins
        self.draws = draws
        self.losses = losses
        self.goalAgain = goalAgain
        self.goalDifference = goalDifference
    }
    
    static func form(goal : Int, goalAgain: Int, goalDifference: Int, wins : Int, draws : Int, losses : Int) ->
        StandingDetails {
            let result = Standing(goal : goal, goalAgain: goalAgain, goalDifference: goalDifference, wins : wins, draws : draws, losses : losses)
            
            return result
    }
}
