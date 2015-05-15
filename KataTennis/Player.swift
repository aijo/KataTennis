//
//  Player.swift
//  KataTennis
//
//  Created by Chanintorn Asavavichairoj on 5/12/2558 BE.
//  Copyright (c) 2558 JO. All rights reserved.
//

import Foundation

class Player {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func performGame() -> UInt32 {
        return arc4random()%10
    }
    
}
