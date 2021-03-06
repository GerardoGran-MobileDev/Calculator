//
//  ViewController.swift
//  Calculator
//
//  Created by user192417 on 2/26/21.
//
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    var current = "0"
    var operation = ""
    var lastOperation = ""
    var lastY = 0.0
    var clearText = false
    var hasDecimal = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    func calculate(x: Double, y: Double, operation: String) -> Double{
        // In charge of arithmetic
        switch operation {
        case "÷":
            return x / y
        case "×":
            return x * y
        case "-":
            return x - y
        case "+":
            return x + y
        default:
            return y
        }
    }
    
    @IBAction func getNumber(_ sender: UIButton){
        // Translates number from button to memory

     
        if let numberText = sender.titleLabel?.text {
            if !clearText{
                if (resultLabel.text == "0" && numberText != "."){
                    resultLabel.text = numberText
                } else if (numberText != "."){
                    resultLabel.text = resultLabel.text! + numberText
                } else if !resultLabel.text!.contains(".") {
                    resultLabel.text = resultLabel.text! + numberText
                }
            } else {
                resultLabel.text = numberText
                clearText = false
            }
        }
    }

    @IBAction func equal(_ sender:UIButton){
        // Executes last operation input and displays result
        lastOperation = operation == "" ? lastOperation : operation
        
        if operation.isEmpty{
            let x = Double(resultLabel.text!)
            let y = lastY
            lastY = y
            let result = calculate(x: x!,y: y, operation: lastOperation)
            resultLabel.text = result.clean
        } else {
            let x = Double(current)
            let y = Double(resultLabel.text!)
            lastY = y!
            let result = calculate(x: x!,y: y!, operation: lastOperation)
            resultLabel.text = result.clean
        }
        
        clearText = true
        operation = ""
    }
    
    @IBAction func clear(_ sender:UIButton){
        // Deletes operation so far and resets label to 0
        resultLabel.text = "0"
        current = "0"
        clearText = true
        operation = ""
    }
    
    @IBAction func doOperation(_ sender: UIButton) {
        if let operationText = sender.titleLabel?.text {
            if operation.isEmpty{
                operation = operationText
                current = resultLabel.text ?? "0"
                clearText = true
            } else {
                let x = Double(current)
                let y = Double(resultLabel.text!)
                let result = calculate(x: x!, y: y!, operation: operation)
                //current = result.clean
                resultLabel.text = result.clean
                operation = operationText
                clearText = true
                
            }
        }
    }
    
    @IBAction func makePercent(_ sender:UIButton){
        // If previous operation is nil or = divide by 100
        
        // Else operate with the percentage of the previous number
    }
    
    @IBAction func flipSign(_ sender:UIButton){
        let negative = -Double(resultLabel.text!)!
        resultLabel.text = negative.clean
    }
}

