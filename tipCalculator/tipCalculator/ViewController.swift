//
//  ViewController.swift
//  tipCalculator
//
//  Created by QwertY on 21.10.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    let formatter = NumberFormatter()
    var tipValue: Float = 0.0
    var totalValue: Float = 0.0
    var inputedValue: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberTextField.delegate = self
        
        self.numberTextField.inputAccessoryView = addDoneButtonToKeyboard()
        
        self.slider.value = 50.0
        self.tipLabel.text = "Tip (\(Int(slider.value))%)"
        
        self.slider.addTarget(self, action: #selector(sliderChanged(sender:)), for: UIControl.Event.valueChanged)
        
        
    }
    
    @objc func sliderChanged(sender: UISlider) {
        
        let sliderValue = Int(sender.value)
        tipLabel.text = "Tip (\(sliderValue)%)"
        
        tipValue = inputedValue * floor(slider.value) / 100
        totalValue = inputedValue + tipValue
        
        tipValueLabel.text = String(format: "$%.2f", tipValue)
        totalValueLabel.text = String(format: "$%.2f", totalValue)
    }
    
    
    @objc func doneClicked() {
        
        inputedValue = formatter.number(from: numberTextField.text!)!.floatValue
        
        numberTextField.text = String(format: "$%.2f", inputedValue)
        
        tipValue = inputedValue * slider.value / 100
        totalValue = inputedValue + tipValue
        
        tipValueLabel.text = String(format: "$%.2f", tipValue)
        totalValueLabel.text = String(format: "$%.2f", totalValue)
        
        view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.numberTextField.resignFirstResponder()
    }
    
    func addDoneButtonToKeyboard() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        return toolBar
    }
}

