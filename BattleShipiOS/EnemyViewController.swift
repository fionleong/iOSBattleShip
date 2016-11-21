//
//  EnemyViewController.swift
//  BattleShipiOS
//
//  Created by Foodie Fion on 11/16/16.
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import UIKit

class EnemyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell"
    var count = 1
    let gridSize = 100
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GridCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = String(count)
        count += 1
        
        cell.myLabel.textColor = UIColor.clear
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.isSelected = false
        
        // displaying all the cells where they have launched missiles previously
        if (self.title == "P1EnemyView")
        {
            if (SharingManager.sharedInstance.player1GridUpdate != [])
            {
                for (_, number) in SharingManager.sharedInstance.player2GridUpdate.enumerated() {
                    if (String(number) == cell.myLabel.text)
                    {
                        if (SharingManager.sharedInstance.player2SLString.range(of: String(number)) != nil)
                        {
                            cell.backgroundColor = UIColor.red
                        }
                        else
                        {
                            cell.backgroundColor = UIColor.blue
                            cell.tag = 1
                        }
                    }
                }
            }
        }
        else if (self.title == "P2EnemyView")
        {
            if (SharingManager.sharedInstance.player1GridUpdate != [])
            {
                for (_, number) in SharingManager.sharedInstance.player1GridUpdate.enumerated() {
                    if (String(number) == cell.myLabel.text)
                    {
                        if (SharingManager.sharedInstance.player1SLString.range(of: String(number)) != nil)
                        {
                            cell.backgroundColor = UIColor.red
                        }
                        else
                        {
                            cell.backgroundColor = UIColor.blue
                        }
                    }
                }
            }
        }
        return cell
    }
    
    // When the user selects one of the cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var curPlayer: Int = 0
        var shipLocation: Int = 0
        var curIndex: Int
        let cell = collectionView.cellForItem(at: indexPath)
        
        if (self.title == "P1EnemyView")
        {
            curPlayer = 1
            cell?.isSelected = true
            shipLocation = appDelegate.player2Model.shipLayout
        }
        else if (self.title == "P2EnemyView")
        {
            curPlayer = 2
            cell?.isSelected = true
            shipLocation = appDelegate.player1Model.shipLayout
        }
        
        curIndex = indexPath.item + 1
        
        // call LaunchMissile() from Model
        if (GridModel().launchMissile(index: curIndex, currentPlayer: curPlayer, enemyShipLayout: shipLocation) == "Hit")
        {
            cell?.backgroundColor = UIColor.red
        }
        else
        {
            cell?.backgroundColor = UIColor.blue
        }
        
        // Check score of the players and display alert message if one of the players won
        if (GridModel().checkScore() == 1)
        {
            let alertController = UIAlertController(title: "GAME OVER", message: "PLAYER 1 WON!", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if (GridModel().checkScore() == 2)
        {
            let alertController = UIAlertController(title: "GAME OVER", message: "PLAYER 2 WON!", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
