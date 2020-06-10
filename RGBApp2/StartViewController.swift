//
//  ViewController.swift
//  RGBApp
//
//  Created by Гордей Гусельников on 07.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Setup" {
            let setupVC = segue.destination as! SetupViewController
            setupVC.myDelegate = self
            setupVC.currentColor = view.backgroundColor
        }
    }
}

extension StartViewController: ColorViewControllerDelegate {
    func updateView(color: UIColor) {
        view.backgroundColor = color
    }
}
