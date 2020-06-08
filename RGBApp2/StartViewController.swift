//
//  ViewController.swift
//  RGBApp
//
//  Created by Гордей Гусельников on 07.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, StartViewControllerDelegate {

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Setup" {
            let setupVC = segue.destination as! SetupViewController
            let color = view.backgroundColor.self
            setupVC.color = color
            setupVC.myDelegate = self
        }
    }
    
    func updateView(color: UIColor) {
        view.backgroundColor = color
    }
}

protocol StartViewControllerDelegate: class {
    func updateView(color: UIColor)
}

