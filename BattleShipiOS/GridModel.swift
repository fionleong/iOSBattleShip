//
//  GridModel.swift
//  BattleShipiOS
//
//  Created by Foodie Fion on 11/17/16.
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import UIKit

class GridModel {
    
    var shipLayout: Int
    
    var player1Life: Int = 17
    var player2Life: Int = 17
    var player1GridUpdate: [Int] = []
    var player2GridUpdate: [Int] = []
    
    
    init() {
        self.shipLayout = 0
    }
    
    func linesFromResource(fileName: String) -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil)
            else {
                fatalError("Resource file for \(fileName) not found.")
        }
        do {
            let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\n")
        } catch let error {
            fatalError("Could not load strings from \(path): \(error).")
        }
    }
    
    // Take the index that was selected and check the index if it matches the opponent's grid
    func launchMissile(index: Int, currentPlayer: Int, enemyShipLayout: Int) -> String {
        // Read in the lists of preset layout
        let shipLocationArray = GridModel().linesFromResource(fileName: "shiplocation.txt")
        
        // Setting the random ship location
        let shipLocationString = shipLocationArray[enemyShipLayout]
        let shipLocationStringArray = shipLocationString.components(separatedBy: " ")
        var currentShipLocationStringArray = shipLocationStringArray
        
        
        // get the opponent's shiplocation #
        if (currentPlayer == 1)
        {
            SharingManager.sharedInstance.player1GridUpdate.append(index)
            print("P1Grid = \(SharingManager.sharedInstance.player1GridUpdate)")
            for i in currentShipLocationStringArray {
                if (i == String(index))
                {
                    SharingManager.sharedInstance.player2Life -= 1
                    print("Player 2 Life = \(SharingManager.sharedInstance.player2Life)")
                    print("Hit")
                    return "Hit"
                }
            }
        }
        else if (currentPlayer == 2)
        {
            SharingManager.sharedInstance.player2GridUpdate.append(index)
            print("P2Grid = \(SharingManager.sharedInstance.player2GridUpdate)")
            for i in currentShipLocationStringArray {
                if (i == String(index))
                {
                    SharingManager.sharedInstance.player1Life -= 1
                    print("Player 1 Life = \(SharingManager.sharedInstance.player1Life)")
                    print("Hit")
                    return "Hit"
                }
            }
            
        }
        print("Missed")
        return "Missed"
    }
    
    
    func checkScore() {
        if (SharingManager.sharedInstance.player1Life == 0)
        {
            // Display an alert that Player 2 won
        }
        
        if (SharingManager.sharedInstance.player2Life == 0)
        {
            // Display an alert that Player 1 won
        }
    }
}
