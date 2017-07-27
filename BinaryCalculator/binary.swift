//
//  binary.swift
//  BinaryCalculator
//
//  Created by Hitain Goyal on 7/26/17.
//  Copyright © 2017 Hitain Goyal. All rights reserved.
//

import UIKit

class binary: NSObject {
    
    var operand = String()
    var waitingForOperand = Bool()
    var waitingOperand = String()
    var waitingOperation = String()

    func performOperation(operation: String) ->String {
        switch operation {
        case "=":
            let originalOperand = operand
            
            performWaitingOperation()
            
            if !waitingForOperand {
                waitingOperand = originalOperand
                waitingForOperand = true
            }
            
        case "+", "-", "/", "*":
            if !waitingForOperand {
                performWaitingOperation()
            }
            waitingOperand = operand
            waitingOperation = operation
            
        default:
            break
        }
        
        return operand
    }
  
//performs operation as per selected
    func addBinary(a:String, b:String) -> String {
        func toInt(binaryString: String) -> Int {
            return strtol(binaryString, nil, 2)
        }
        
        let _a = toInt(binaryString: a)
        let _b = toInt(binaryString: b)
        
        return String(_a + _b, radix: 2)
    }
    func subtractBinary(a:String, b:String) -> String {
        func toInt(binaryString: String) -> Int {
            return strtol(binaryString, nil, 2)
        }
        
        let _a = toInt(binaryString: a)
        let _b = toInt(binaryString: b)
        
        return String(_a - _b, radix: 2)
    }
    func multiplyBinary(a:String, b:String) -> String {
        func toInt(binaryString: String) -> Int {
            return strtol(binaryString, nil, 2)
        }
        
        let _a = toInt(binaryString: a)
        let _b = toInt(binaryString: b)
        
        return String(_a * _b, radix: 2)
    }
    func divideBinary(a:String, b:String) -> String {
        func toInt(binaryString: String) -> Int {
            return strtol(binaryString, nil, 2)
        }
        
        let _a = toInt(binaryString: a)
        let _b = toInt(binaryString: b)
        
        return String(_a / _b, radix: 2)
    }


    func performWaitingOperation() {
        
        let toOperand = operand._bridgeToObjectiveC()
        let toWaitingOperand = waitingOperand._bridgeToObjectiveC()
        
        switch waitingOperation {
            
        case "+":
            operand = addBinary(a:toOperand as String, b:toWaitingOperand as String)
            
            
        case "-":
            operand = waitingForOperand ?
                subtractBinary(a:toOperand as String, b:toWaitingOperand as String) :
            subtractBinary(a:toWaitingOperand as String, b:toOperand as String)
            
        case "*":
            operand = multiplyBinary(a:toOperand as String, b:toWaitingOperand as String)
            
            
        case "/":
            operand = waitingForOperand ?
                divideBinary(a:toOperand as String, b:toWaitingOperand as String) :
            divideBinary(a:toWaitingOperand as String, b:toOperand as String)
            
        default:
            waitingForOperand = true
        }
    }
    
    func clearTapped() {
        waitingOperand = ""
        waitingOperation = ""
        operand = ""
    }
    
    func setNotWaitingForOperand() {
        waitingForOperand = false
    }
    
} //EOF
