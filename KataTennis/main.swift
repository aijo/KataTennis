//
//  main.swift
//  KataTennis
//
//  Created by Chanintorn Asavavichairoj on 5/12/2558 BE.
//  Copyright (c) 2558 JO. All rights reserved.
//

import Foundation

var game = Game()

game.addPlayer(Player(name: "1"), side: .A)
game.addPlayer(Player(name: "2"), side: .B)

println("Start Game!")
println("A = \(game.getScore(.A).description) | B = \(game.getScore(.B).description)")

while(true) {
    println("\(game.startGame().description) Point!")
    println("A = \(game.getScore(.A).description) | B = \(game.getScore(.B).description)")
    
    if let winner = game.gameWinner {
        println("\(winner.description) is won!")
        break
    }
    sleep(1)
}
