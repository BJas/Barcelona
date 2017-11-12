//
//  File.swift
//  BarcelonaApp
//
//  Created by Apple on 12.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Standing {
    var position : Int
    var teamName : String
    var points : Int
    var goal : Int
    var games : Int
    var wins : Int
    var draws : Int
    var losses : Int
    
    init(position: Int, teamName : String, points :Int, goal : Int, wins : Int, draws : Int, losses : Int, games : Int){
        self.position = position
        self.teamName = teamName
        self.points = points
        self.goal = goal
        self.wins = wins
        self.draws = draws
        self.losses = losses
        self.games = games
    }
    
    static func form(position: Int, teamName : String, points :Int, goal : Int, wins : Int, draws : Int, losses : Int, games : Int) ->
        Standing{
            let result = Standing(position: position, teamName : teamName, points : points, goal : goal, wins : wins, draws : draws, losses : losses, games : games)
            
            return result
    }
}
