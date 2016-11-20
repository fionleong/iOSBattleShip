//
//  EnemyViewController.swift
//  BattleShipiOS
//
//  Created by Foodie Fion on 11/16/16.
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import UIKit

class EnemyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var count = 1
    let gridSize = 100
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - UICollectionViewDataSource protocol
    
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
        
        //cell.myLabel.textColor = UIColor.clear
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.isSelected = false
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var curPlayer: Int = 0
        var shipLocation: Int = 0
        var curIndex: Int
        let cell = collectionView.cellForItem(at: indexPath)
        
        if (self.title == "P1EnemyView")
        {
            curPlayer = 1
            shipLocation = appDelegate.player2Model.shipLayout
        }
        else if (self.title == "P2EnemyView")
        {
            curPlayer = 2
            shipLocation = appDelegate.player1Model.shipLayout
        }
        
        curIndex = indexPath.item + 1
        print("Current Player = \(curPlayer)")
        print("Selected Grid Index = \(curIndex)")
        print("ShipLocation of opponent = \(shipLocation)")
        // call LaunchMissile() from Model
        if (GridModel().launchMissile(index: curIndex, currentPlayer: curPlayer, enemyShipLayout: shipLocation) == "Hit")
        {
            cell?.backgroundColor = UIColor.red
        }
        else
        {
            cell?.backgroundColor = UIColor.cyan
        }
    }
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if (cell?.isSelected == false)
        {
            cell?.isSelected = true
            cell?.backgroundColor = UIColor.yellow
        }
        else {
            cell?.isSelected = false
            cell?.backgroundColor = UIColor.white
        }
        
    }

}
