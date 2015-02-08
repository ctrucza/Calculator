//
//  ViewController.swift
//  Calculator
//
//  Created by Csaba Trucza on 2/8/15.
//  Copyright (c) 2015 Csaba Trucza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if (digit == ".")
            {
                let range = display.text!.rangeOfString(".")
                if (range != nil) {
                    return
                }
            }
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $1 * $0 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $1 + $0 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation {sin($0)}
        case "cos": performOperation {cos($0)}
        case "∏": putConstantOnStack(M_PI)
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double)
    {
        if (operandStack.count >= 2){
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double)
    {
        if (operandStack.count >= 1){
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func putConstantOnStack(value: Double)
    {
        displayValue = value
        enter()
    }

    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

