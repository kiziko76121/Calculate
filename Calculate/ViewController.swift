//
//  ViewController.swift
//  Calculate
//
//  Created by Mojo on 2019/8/29.
//  Copyright © 2019 Mojo. All rights reserved.
//

import UIKit

enum Sign{
    case nothing
    case plus
    case minus
    case multi
    case division
}

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    let formatter = NumberFormatter()
    
    var firstNumber : Double = 0.0
    var secondNumber : Double = 0.0
    var currentSign = Sign.nothing
    var isCalculating :Bool = false
    var startNew :Bool = true
    var operatingSign :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = .decimal
    }
    @IBAction func numbersPress(_ sender: UIButton) {
        let imputNumber = sender.tag-1
        if resultLabel.text != nil{
            if self.startNew{
                resultLabel.text = "\(imputNumber)"
                self.startNew = false
            }else{
                if  self.operatingSign == "+" || self.operatingSign == "-"
                    || self.operatingSign == "x" || self.operatingSign == "/"{
                    resultLabel.text = "\(imputNumber)"
                    self.operatingSign = ""
                }else{
                    resultLabel.text! += "\(imputNumber)"
                    if imputNumber != 0 || (imputNumber == 0 && !(resultLabel.text!.contains(".")) ){
                        resultLabel.text! = self.checkNumber(number: resultLabel.text!)
                    }
                    
                }
            }
            self.secondNumber = Double(resultLabel.text!) ?? 0
        }
        
    }
    
    @IBAction func clearPress(_ sender: Any) {
        resultLabel.text = "0"
        firstNumber = 0
        secondNumber = 0
        currentSign = Sign.nothing
        isCalculating = false
        startNew = true
        operatingSign = ""
    }
    @IBAction func pointPress(_ sender: Any) {
        if !(resultLabel.text!.contains(".")){
            resultLabel.text! += "."
        }
    }
    
    @IBAction func plus(_ sender: Any) {
        if self.firstNumber != 0 {
            self.continut()
        }
        self.operatingSign = "+"
        self.currentSign = Sign.plus
        self.isCalculating = true
        self.startNew = false
        self.firstNumber = self.secondNumber
    }
    
    @IBAction func minus(_ sender: Any) {
        if self.firstNumber != 0 {
            self.continut()
        }
        self.operatingSign = "-"
        self.currentSign = Sign.minus
        self.isCalculating = true
        self.startNew = false
        self.firstNumber = self.secondNumber
    }
    
    @IBAction func multi(_ sender: Any) {
        if self.firstNumber != 0 {
            self.continut()
        }
        self.operatingSign = "x"
        self.currentSign = Sign.multi
        self.isCalculating = true
        self.startNew = false
        self.firstNumber = self.secondNumber
    }
    
    @IBAction func division(_ sender: Any) {
        if self.firstNumber != 0 {
            self.continut()
        }
        self.operatingSign = "/"
        self.currentSign = Sign.division
        self.isCalculating = true
        self.startNew = false
        self.firstNumber = self.secondNumber
        
    }
    
    @IBAction func equal(_ sender: Any) {
        if self.isCalculating {
            switch currentSign {
            case .plus:
//                self.secondNumber = Double(resultLabel.text!) ?? 0
                resultLabel.text = checkNumber(number: String(firstNumber + secondNumber))
                self.secondNumber = firstNumber + secondNumber
                currentSign = Sign.nothing
            case .minus:
//                self.secondNumber = Double(resultLabel.text!) ?? 0
                resultLabel.text = checkNumber(number: String(firstNumber - secondNumber))
                self.secondNumber = firstNumber - secondNumber
                currentSign = Sign.nothing
            case .multi:
//                self.secondNumber = Double(resultLabel.text!) ?? 0
                resultLabel.text = checkNumber(number: String(firstNumber * secondNumber))
                self.secondNumber = firstNumber * secondNumber
                currentSign = Sign.nothing
            case .division:
//                self.secondNumber = Double(resultLabel.text!) ?? 0
                resultLabel.text = checkNumber(number: String(firstNumber / secondNumber))
                self.secondNumber = firstNumber / secondNumber
                currentSign = Sign.nothing
            case .nothing:
                break
            }
            self.isCalculating = false
            self.startNew = true
        }
        self.firstNumber = 0
    }
    
    func continut(){
        switch currentSign {
        case .plus:
            resultLabel.text = checkNumber(number: String(firstNumber + secondNumber))
            self.secondNumber = firstNumber + secondNumber
            currentSign = Sign.nothing
        case .minus:
            resultLabel.text = checkNumber(number: String(firstNumber - secondNumber))
            self.secondNumber = firstNumber - secondNumber
            currentSign = Sign.nothing
        case .multi:
            resultLabel.text = checkNumber(number: String(firstNumber * secondNumber))
            self.secondNumber = firstNumber * secondNumber
            currentSign = Sign.nothing
        case .division:
            resultLabel.text = checkNumber(number: String(firstNumber / secondNumber))
            self.secondNumber = firstNumber / secondNumber
            currentSign = Sign.nothing
        case .nothing:
            break
        }
    }
    
    @IBAction func percentage(_ sender: Any) {
        guard let resultText = resultLabel.text ,let number = Double(resultText) else{
            return
        }
        resultLabel.text = checkNumber(number: String(number / 100))
        self.secondNumber = number / 100
        self.isCalculating = true
        self.startNew = false
    }
    
    @IBAction func signChange(_ sender: Any) {
        guard let resultText = resultLabel.text ,let number = Double(resultText) else{
            return
        }
        self.secondNumber = number * -1
        resultLabel.text = checkNumber(number: String(number * -1))
        self.isCalculating = true
        self.startNew = false
    }
    
    func checkNumber(number :String)->String{
        let stringOfNumber : NSNumber = formatter.number(from: number)!
        let string = String(describing: stringOfNumber)
        return string
    }
}

