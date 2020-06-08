//
//  SetupViewController.swift
//  RGBApp
//
//  Created by Гордей Гусельников on 07.06.2020.
//  Copyright © 2020 gordeyStudio. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var viewRGB: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var color: UIColor!
    
    weak var myDelegate: StartViewControllerDelegate?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSettings()
        viewRGB.backgroundColor = color
        colorToSliders(color: color)
        changeBackgroundColorView()
        setValue(for: redLabel, and: redTextField, from: redSlider)
        setValue(for: greenLabel, and: greenTextField, from: greenSlider)
        setValue(for: blueLabel, and: blueTextField, from: blueSlider)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0: setValue(for: redLabel, and: redTextField, from: sender)
        case 1: setValue(for: greenLabel, and: greenTextField, from: sender)
        case 2: setValue(for: blueLabel, and: blueTextField, from: sender)
        default: break
        }
        changeBackgroundColorView()
    }
    
    @IBAction func doneButtonPressed() {
        myDelegate?.updateView(color: color)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func viewSettings() {
        viewRGB.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        redTextField.returnKeyType = .done
        greenTextField.returnKeyType = .done
        blueTextField.returnKeyType = .done
    }
    
    private func changeBackgroundColorView() {
        viewRGB.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        color = viewRGB.backgroundColor
    }
    
    private func colorToSliders(color: UIColor) {
        redSlider.value = Float(color.components.red)
        greenSlider.value = Float(color.components.green)
        blueSlider.value = Float(color.components.blue)
    }

    private func setValue(for label: UILabel, and textField: UITextField, from slider: UISlider) {
        label.text = string(from: slider)
        textField.text = string(from: slider)
    }

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: - Text Field Delegate
extension SetupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let number = Float(redTextField.text!) {
            redSlider.value = number
            setValue(for: redLabel, and: redTextField, from: redSlider)
            changeBackgroundColorView()
        } else {
            textField.text = "Err"
        }

        if let number = Float(greenTextField.text!) {
            greenSlider.value = number
            setValue(for: greenLabel, and: greenTextField, from: greenSlider)
            changeBackgroundColorView()
        } else {
            textField.text = "Err"
        }

        if let number = Float(blueTextField.text!) {
            blueSlider.value = number
            setValue(for: blueLabel, and: blueTextField, from: blueSlider)
            changeBackgroundColorView()
        } else {
            textField.text = "Err"
        }
    }
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}
