//
//  ViewController.swift
//  Convert It
//
//  Created by Jimmy McDermott on 9/28/17.
//  Copyright © 2017 162 LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var userInput: UITextField!
    @IBOutlet private weak var fromUnitsLabel: UILabel!
    @IBOutlet private weak var resultsLabel: UILabel!
    @IBOutlet private weak var formulaPicker: UIPickerView!
    
    private var fromUnits = ""
    private var toUnits = ""
    private var conversionString = ""
    private var formulasArray = [
        "miles to kilometers",
        "kilometers to miles",
        "feet to meters",
        "yards to meters",
        "meters to feet",
        "meters to yards"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
    }
    
    private func calculateConversion() {
        var outputValue = 0.0
        
        if let inputValue = Double(userInput.text!) {
            switch conversionString {
            case "miles to kilometers":
                outputValue = inputValue / 0.62137
            case "kilometers to miles":
                outputValue = inputValue * 0.62137
            case "feet to meters":
                outputValue = inputValue / 3.2808
            case "yards to meters":
                outputValue = inputValue / 0.62137
            case "meters to feet":
                outputValue = inputValue * 3.2808
            case "meters to yards":
                outputValue = inputValue * 1.0936
            default:
                print("show alert")
            }
            
            resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputValue) \(toUnits)"
        } else {
            print("show alert")
        }
        
        
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction private func convertButtonPressed(_ sender: UIButton) {
        
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulasArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulasArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitsLabel.text = fromUnits
        resultsLabel.text = toUnits
        conversionString = formulasArray[row]
        calculateConversion()
    }
}
