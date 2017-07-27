//
//  ViewController.swift
//  BinaryCalculator
//
//  Created by Hitain Goyal on 7/25/17.
//  Copyright © 2017 Hitain Goyal. All rights reserved.
//

import UIKit
import CoreFoundation

class ViewController: UIViewController {
    
// text is updated
    @IBOutlet weak var inputLabel: UILabel!
    
    var isTypingNumber = false
    
    let Binary = binary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayText: NSString = "" {
        didSet {
            inputLabel.text = displayText as String
        }
    }
//digit is tapped and stored as string
    @IBAction func digitTapped(button: UIButton) {
        
        let value = button.titleLabel?.text
        
        if displayText == "0" && value == "0" {
            isTypingNumber = false
            return
        }
        
        if (isTypingNumber) {
            if value != "." || value == "." && !displayText.contains(".") {
                displayText = displayText.appending(value!) as NSString
            }
        } else {
            displayText = value! as NSString
            isTypingNumber = true
            Binary.setNotWaitingForOperand()
        }
        
    }
//to reset the text or label
    @IBAction func clearTapped() {
        Binary.clearTapped()
        displayText = ""
    }

    @IBAction func operationTapped(button: UIButton) {
        let operation = button.titleLabel?.text
        
        if (isTypingNumber) {
            Binary.operand = displayText as String
            isTypingNumber = false
        }
        
        if (operation == "=") {
            if !Binary.waitingForOperand {
                Binary.operand = Binary.operand
                isTypingNumber = false
            } else {
                Binary.operand = displayText as String
            }
        }
        
        var result = Binary.performOperation(operation: operation!)
        
        let value = result._bridgeToObjectiveC().floatValue
        let int = result._bridgeToObjectiveC().integerValue
        if (Double(value) - Double(int) == 0) {
            // no floating
            result = "\(result._bridgeToObjectiveC().integerValue)"
        }
        
        displayText = result as NSString
    }
    
}


