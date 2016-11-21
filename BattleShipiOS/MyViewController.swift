//
//  ViewController.swift
//  BattleShipiOS
//
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentShipLocationStringArrayP1: [String] = []
    var currentShipLocationStringArrayP2: [String] = []
    
    let gridSize = 100
    var count = 1;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Read in the lists of preset layout
        let shipLocationArray = GridModel().linesFromResource(fileName: "shiplocation.txt")
        
        // Setting the random ship location for P1
        let shipLocationStringP1 = shipLocationArray[appDelegate.player1Model.shipLayout]
        SharingManager.sharedInstance.player1SLString = shipLocationStringP1
        
        let shipLocationStringArrayP1 = shipLocationStringP1.components(separatedBy: " ")
        currentShipLocationStringArrayP1 = shipLocationStringArrayP1
        print("SL P1 = \(currentShipLocationStringArrayP1)")
        
        // Setting the random ship location for P2
        let shipLocationStringP2 = shipLocationArray[appDelegate.player2Model.shipLayout]
        SharingManager.sharedInstance.player2SLString = shipLocationStringP2
        
        let shipLocationStringArrayP2 = shipLocationStringP2.components(separatedBy: " ")
        currentShipLocationStringArrayP2 = shipLocationStringArrayP2
        print("SL P2 = \(currentShipLocationStringArrayP2)")
        
        // Sort gridUpdate array
        SharingManager.sharedInstance.player1GridUpdate = SharingManager.sharedInstance.player1GridUpdate.sorted { $0 < $1 }
        print("Sorted P1Grid = \(SharingManager.sharedInstance.player1GridUpdate)")
        SharingManager.sharedInstance.player2GridUpdate = SharingManager.sharedInstance.player2GridUpdate.sorted { $0 < $1 }
        print("Sorted P2Grid = \(SharingManager.sharedInstance.player2GridUpdate)")
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GridCollectionViewCell
        
        cell.myLabel.text = String(count)
        count += 1
        
        //cell.myLabel.textColor = UIColor.clear
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        
        // tag = 0, not a ship; tag = 1, is part of a ship
        cell.tag = 0
        
        // Populate the shiplocation accordingly along with enemy attacks location
        if (self.title == "P1MyView")
        {
            for (_, number) in currentShipLocationStringArrayP1.enumerated() {
                if (number == cell.myLabel.text)
                {
                    cell.backgroundColor = UIColor.lightGray
                    cell.tag = 1
                }
            }
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
                            cell.backgroundColor = UIColor.orange
                            cell.tag = 1
                        }
                    }
                }
            }
        }
        else if (self.title == "P2MyView")
        {
            for (_, number) in currentShipLocationStringArrayP2.enumerated() {
                if (number == cell.myLabel.text)
                {
                    cell.backgroundColor = UIColor.lightGray
                    cell.tag = 1
                }
            }
            if (SharingManager.sharedInstance.player2GridUpdate != [])
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
                            cell.backgroundColor = UIColor.orange
                            cell.tag = 1
                        }
                    }
                }
            }
        }
        return cell
    }
    
}
