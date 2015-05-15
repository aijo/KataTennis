//
//  Test.swift
//  Test
//
//  Created by Chanintorn Asavavichairoj on 5/12/2558 BE.
//  Copyright (c) 2558 JO. All rights reserved.
//

import Cocoa
import XCTest

class Test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testScoreShouldIncreaseCorrectly() {
        var game = Game()
        var side = Game.Side.A
        
        XCTAssertEqual(game.getScore(side), Game.Scores.ZERO, "player should have zero score")
        game.increaseScore(side)
        XCTAssertEqual(game.getScore(side), Game.Scores.FIFTEEN, "player should have fifteen score")
        game.increaseScore(side)
        XCTAssertEqual(game.getScore(side), Game.Scores.THIRTY, "player should have thirty score")
        game.increaseScore(side)
        XCTAssertEqual(game.getScore(side), Game.Scores.FOURTY, "player should have fourty score")
    }
    
    func testPlayerShouldDeuceWhenBothSideGotFourty() {
        var game = Game()
        game.increaseScore(.A)//15
        game.increaseScore(.A)//30
        game.increaseScore(.A)//40
        XCTAssertEqual(game.getScore(.A), Game.Scores.FOURTY, "first player should have fourty score")
        
        game.increaseScore(.B)//15
        game.increaseScore(.B)//30
        game.increaseScore(.B)//40
        XCTAssertEqual(game.getScore(.B), Game.Scores.FOURTY, "second player should have fourty score")
        
        game.increaseScore(.A)
        XCTAssertEqual(game.getScore(.A), Game.Scores.DEUCE, "first player should deuce when players got fourty")
        XCTAssertEqual(game.getScore(.B), Game.Scores.DEUCE, "first player should deuce when players got fourty")
    }
    
    func testPlayerShouldGotAdvanceWhenBothSideGotDeuceAndWin() {
        var game = Game()
        game.increaseScore(.A)//15
        game.increaseScore(.A)//30
        game.increaseScore(.A)//40
        
        game.increaseScore(.B)//15
        game.increaseScore(.B)//30
        game.increaseScore(.B)//40
        
        game.increaseScore(.A)//Deuce
        game.increaseScore(.A)//Advance
        XCTAssertEqual(game.getScore(.A), Game.Scores.ADVANCE, "player should got advance when players got deuce")
    }
    
    func testPlayerShouldWinAfterGotAdvanceAndOpponentIsNot() {
        var game = Game()
        game.increaseScore(.A)//15
        game.increaseScore(.A)//30
        game.increaseScore(.A)//40
        
        game.increaseScore(.B)//15
        game.increaseScore(.B)//30
        game.increaseScore(.B)//40
        
        game.increaseScore(.A)//Deuce
        game.increaseScore(.A)//Advance
        game.increaseScore(.A)//Game
        XCTAssertEqual(game.getScore(.A), Game.Scores.GAME, "player should win after got advance")
    }
    
    func testPlayerShouldBackToDeuceAgainAfterOpponetIsWinAfterDeuce() {
        var game = Game()
        game.increaseScore(.A)//15
        game.increaseScore(.A)//30
        game.increaseScore(.A)//40
        
        game.increaseScore(.B)//15
        game.increaseScore(.B)//30
        game.increaseScore(.B)//40
        
        game.increaseScore(.A)//Deuce
        game.increaseScore(.A)//Advance
        XCTAssertEqual(game.getScore(.A), Game.Scores.ADVANCE, "player should got advance when players got deuce")
        game.increaseScore(.B)
        XCTAssertEqual(game.getScore(.A), Game.Scores.DEUCE, "first player should deuce again after opponet is win")
        XCTAssertEqual(game.getScore(.B), Game.Scores.DEUCE, "first player should deuce again after opponet is win")
    }
    
    func testPlayerShouldWinAfterGotFourtyAndOpponentIsNot() {
        var game = Game()
        game.increaseScore(.A)//15
        game.increaseScore(.A)//30
        game.increaseScore(.A)//40
        XCTAssertEqual(game.getScore(.A), Game.Scores.FOURTY, "first player should have fourty score")
        
        game.increaseScore(.B)//15
        XCTAssertEqual(game.getScore(.B), Game.Scores.FIFTEEN, "second player should have fifteen score")
        
        game.increaseScore(.A)
        XCTAssertEqual(game.getScore(.A), Game.Scores.GAME, "first player should win after got fourty")
    }
    
}
