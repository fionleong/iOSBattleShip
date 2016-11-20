//
//  SharingManager.swift
//  BattleShipiOS
//
//  Created by Foodie Fion on 11/19/16.
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import Foundation

class SharingManager {
    var player1Life: Int = 17
    var player2Life: Int = 17
    var player1GridUpdate: [Int] = []
    var player2GridUpdate: [Int] = []
    static let sharedInstance = SharingManager()
}
