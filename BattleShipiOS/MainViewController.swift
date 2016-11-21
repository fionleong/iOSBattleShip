//
//  MainViewController.swift
//  BattleShipiOS
//
//  Created by Foodie Fion on 11/18/16.
//  Copyright © 2016 Fion Leong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let numShipsLayout = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Picking a random number for ship layouts
        var random1 = Int(arc4random_uniform(UInt32(numShipsLayout)))
        let random2 = Int(arc4random_uniform(UInt32(numShipsLayout)))
        
        if (random1 == random2)
        {
            random1 = Int(arc4random_uniform(UInt32(numShipsLayout)))
        }
        
        appDelegate.player1Model.shipLayout = random1
        print("Random1 = \(random1)")
        
        appDelegate.player2Model.shipLayout = random2
        print("Random2 = \(random2)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
