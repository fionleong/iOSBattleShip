//
//  SharingManager.swift
//  BattleShipiOS
//
//  Created by Foodie Fion on 11/19/16.
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import Foundation

class SharingManager {
    var player1Life: Int = 1
    var player2Life: Int = 1
    var player1GridUpdate: [Int] = []
    var player2GridUpdate: [Int] = []
    var player1SLString: String = ""
    var player2SLString: String = ""
    static let sharedInstance = SharingManager()
}
