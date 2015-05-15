//
//  Game.swift
//  KataTennis
//
//  Created by Chanintorn Asavavichairoj on 5/12/2558 BE.
//  Copyright (c) 2558 JO. All rights reserved.
//

import Foundation

class Game {
    
    enum Scores: Int {
        case ZERO = 0
        case FIFTEEN = 1
        case THIRTY = 2
        case FOURTY = 3
        case DEUCE = 4
        case ADVANCE = 5
        case GAME = 6
        case UNKNOW = 7
        
        var description : String {
            switch self {
            case .ZERO: return "0";
            case .FIFTEEN: return "15";
            case .THIRTY: return "30";
            case .FOURTY: return "40";
            case .DEUCE: return "Deuce";
            case .ADVANCE: return "Adv";
            case .GAME: return "Game";
            default: return "Unknow";
            }
        }
    }
    
    enum Side: Int {
        case A = 0
        case B = 1
        case UNKNOW = 2
        
        var description : String {
            switch self {
            case .A: return "A";
            case .B: return "B";
            default: return "-";
            }
        }
    }
    
    var players: [Side: [Player]]
    var scores: [Side: Scores]
    var startSide: Side
    var gameWinner: Side?
    
    init() {
        players = [.A: [Player](), .B: [Player]()]
        scores = [.A: .ZERO, .B: .ZERO]
        startSide = Side(rawValue: Int(arc4random()%1))!
    }
    
    func addPlayer(player:Player, side:Side) {
        if players[side]?.count < 2 {
            players[side]?.append(player)
        }
    }
    
    func getScore(side:Side) -> Scores {
        if let score = scores[side] {
            return score
        }
        return .UNKNOW
    }
    
    func performGame() -> (Side, Scores) {
        if let winner = gameWinner {
            return (winner, getScore(winner))
        }
        
        var sideAPerform = 0
        if let players = players[.A] {
            for p in players {
                sideAPerform += Int(p.performGame())
            }
        }
        
        var sideBPerform = 0
        if let players = players[.B] {
            for p in players {
                sideBPerform += Int(p.performGame())
            }
        }
        
        var winner = Side.UNKNOW
        var score = Scores.UNKNOW
        if sideAPerform > sideBPerform {
            winner = .A
            score = increaseScore(winner)
        } else if sideAPerform < sideBPerform {
            winner = .B
            score = increaseScore(winner)
        }
        
        return (winner, score)
    }
    
    func increaseScore(side:Side) -> Scores {
        var score = getScore(side).rawValue+1
        if let newScore = Scores(rawValue: score) {
            if newScore == .DEUCE {
                if getScore(.A) == getScore(.B) {
                    scores[.A] = .DEUCE
                    scores[.B] = .DEUCE
                } else {
                    scores[side] = .GAME
                    gameWinner = side
                }
            } else if newScore == .ADVANCE {
                if getScore(.A) == getScore(.B) {
                    scores[side] = newScore
                } else {
                    scores[.A] = .DEUCE
                    scores[.B] = .DEUCE
                }
            } else if newScore == .GAME {
                scores[side] = .GAME
                gameWinner = side
            } else {
                scores[side] = newScore
            }
            return getScore(side)
        }
        return .UNKNOW
    }
    
    func startGame() -> Side {
        var game = performGame()
        var winner = game.0
        var score = game.1
        
        return winner
    }
    
}
