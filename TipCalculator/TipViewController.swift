//
//  ViewController.swift
//  TipCalculator
//
//  Created by szarif on 8/2/17.
//  Copyright © 2017 szarif. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var digitAtIndexOne: UILabel!

    @IBOutlet weak var digitAtIndexTwo: UILabel!
    
    @IBOutlet weak var digitAtIndexThree: UILabel!
    @IBOutlet weak var digitAtIndexFour: UILabel!
    
    @IBOutlet weak var tenthLabel: UILabel!
    
    @IBOutlet weak var hunderthLabel: UILabel!
    
    @IBOutlet weak var dollarSign: UILabel!
    
    @IBOutlet weak var display: UIView!
    
    
    var isDecimalFieldActivated = false
    var isModifyingDecimalField = false
    
    var decimalPointIndex = 0
    var numberIndex = 0
    var currentNumber = 0
    var currentDecimal = 0
    
    private struct Operations {
        static let remove = "<"
        static let decimalPoint = "."
    }
    
    private struct DefaultAnimationSettings {
        static let durationFast: Double = 0.30
        static let durationSlow: Double = 0.20
        static let delay: Double = 0.0
    }
    
    private struct DecimalFieldSettings {
        static let shiftY: CGFloat = 30
        static let onAlpha: CGFloat = 0.20
        static let offAlpha: CGFloat = 0.0
        static let activatedAlpha: CGFloat = 0.7
        
    }
    
    private struct NumberFieldSettings {
        static let shiftY: CGFloat = 60
        static let shiftX: CGFloat = 35
        static let onAlpha: CGFloat = 1.0
        static let offAlpha: CGFloat = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: "tipControlIndex")
        tipControl.selectedSegmentIndex = intValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            switch digit {
                case Operations.remove:
                    isDecimalFieldActivated ? deleteFromDecimalField() : deleteFromNumberField()
                case Operations.decimalPoint:
                    if (!isDecimalFieldActivated) {
                        animateDecimalFieldOn()
                        shiftLeft(label: dollarSign)
                        shiftLeft(label: digitAtIndexOne)
                        shiftLeft(label: digitAtIndexTwo)
                        shiftLeft(label: digitAtIndexThree)
                        shiftLeft(label: digitAtIndexFour)
                    }
                    isDecimalFieldActivated = true
                default:
                    isDecimalFieldActivated ? typeOnDecimalField(digit: digit) : typeOnNumberField(digit: digit)
            }
        }
    }
    
    func animateDecimalFieldOn() {
        UIView.animate(withDuration: DefaultAnimationSettings.durationFast, delay: DefaultAnimationSettings.delay, options: [.curveEaseOut], animations: {
            self.tenthLabel.center.y += DecimalFieldSettings.shiftY
            self.tenthLabel.alpha = DecimalFieldSettings.onAlpha
            
            self.hunderthLabel.center.y += DecimalFieldSettings.shiftY
            self.hunderthLabel.alpha = DecimalFieldSettings.onAlpha
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateDecimalFieldOff() {
        UIView.animate(withDuration: DefaultAnimationSettings.durationFast, delay: DefaultAnimationSettings.delay, options: [.curveEaseOut], animations: {
            self.tenthLabel.center.y -= DecimalFieldSettings.shiftY
            self.tenthLabel.alpha = DecimalFieldSettings.offAlpha
            
            self.hunderthLabel.center.y -= DecimalFieldSettings.shiftY
            self.hunderthLabel.alpha = DecimalFieldSettings.offAlpha
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func shiftLeft(label: UILabel) {
        UIView.animate(withDuration: DefaultAnimationSettings.durationSlow, delay: DefaultAnimationSettings.delay, options: [.curveEaseOut], animations: {
            label.center.x -= NumberFieldSettings.shiftX
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func shiftRight(label: UILabel) {
        UIView.animate(withDuration: DefaultAnimationSettings.durationSlow, delay: DefaultAnimationSettings.delay, options: [.curveEaseOut], animations: {
            label.center.x += NumberFieldSettings.shiftX
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func shiftDown(label: UILabel) {
        UIView.animate(withDuration: DefaultAnimationSettings.durationSlow, delay: DefaultAnimationSettings.delay, options: [.curveEaseOut], animations: {
            label.center.y += NumberFieldSettings.shiftY
            label.alpha = NumberFieldSettings.onAlpha
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func shiftUp(label: UILabel) {
        UIView.animate(withDuration: DefaultAnimationSettings.durationSlow, delay: DefaultAnimationSettings.delay, options: [.curveEaseOut], animations: {
            label.center.y -= NumberFieldSettings.shiftY
            label.alpha = NumberFieldSettings.offAlpha
            self.view.layoutIfNeeded()
        },  completion: {(finished:Bool) in
            // the code you put here will be compiled once the animation finishes
            label.text = "0"
        })
    }
    
    func addDigit(digit: String) {
        let digitIntegerForm = Int(digit) ?? 0
        currentNumber = (currentNumber * 10) + digitIntegerForm
        numberIndex += 1
    }
    
    func removeDigit() {
        currentNumber = (currentNumber / 10)
        numberIndex -= 1
    }
    
    func typeOnNumberField(digit: String) {
        switch numberIndex {
            case 0:
                if (digit != "0") {
                    digitAtIndexOne.text = digit
                    addDigit(digit: digit)
                    calculate()
                } else {
                    display.shake()
                }
            case 1:
                digitAtIndexTwo.text = digit
                shiftLeft(label: digitAtIndexOne)
                shiftLeft(label: dollarSign)
                shiftDown(label: digitAtIndexTwo)
                addDigit(digit: digit)
                calculate()
            case 2:
                digitAtIndexThree.text = digit
                shiftLeft(label: digitAtIndexOne)
                shiftLeft(label: digitAtIndexTwo)
                shiftLeft(label: dollarSign)
                shiftDown(label: digitAtIndexThree)
                addDigit(digit: digit)
                calculate()
            case 3:
                digitAtIndexFour.text = digit
                shiftLeft(label: digitAtIndexOne)
                shiftLeft(label: digitAtIndexTwo)
                shiftLeft(label: digitAtIndexThree)
                shiftLeft(label: dollarSign)
                shiftDown(label: digitAtIndexFour)
                addDigit(digit: digit)
                calculate()
            default:
                display.shake()
                break
        }
    }
    
    func typeOnDecimalField(digit: String) {
        switch decimalPointIndex {
            case 0:
                tenthLabel.text = digit
                tenthLabel.alpha = DecimalFieldSettings.activatedAlpha
                decimalPointIndex += 1
            case 1:
                hunderthLabel.text = digit
                hunderthLabel.alpha = DecimalFieldSettings.activatedAlpha
                decimalPointIndex += 1
            default:
                display.shake()
                break
        }
        
        calculate()
    }
    
    func deleteFromNumberField() {
        switch numberIndex {
            case 1:
                digitAtIndexOne.text = "0"
                removeDigit()
                calculate()
            case 2:
                shiftUp(label: digitAtIndexTwo)
                shiftRight(label: dollarSign)
                shiftRight(label: digitAtIndexOne)
                removeDigit()
                calculate()
            case 3:
                shiftUp(label: digitAtIndexThree)
                shiftRight(label: dollarSign)
                shiftRight(label: digitAtIndexOne)
                shiftRight(label: digitAtIndexTwo)
                removeDigit()
                calculate()
            case 4:
                shiftUp(label: digitAtIndexFour)
                shiftRight(label: dollarSign)
                shiftRight(label: digitAtIndexOne)
                shiftRight(label: digitAtIndexTwo)
                shiftRight(label: digitAtIndexThree)
                removeDigit()
                calculate()
            default:
                display.shake()
                break
        }
    }
    
    func deleteFromDecimalField() {
        switch decimalPointIndex {
            case 0:
                animateDecimalFieldOff()
                
                shiftRight(label: dollarSign)
                shiftRight(label: digitAtIndexOne)
                shiftRight(label: digitAtIndexTwo)
                shiftRight(label: digitAtIndexThree)
                shiftRight(label: digitAtIndexFour)
                
                isDecimalFieldActivated = false
            case 1:
                tenthLabel.text = "0"
                self.tenthLabel.alpha = DecimalFieldSettings.onAlpha
                decimalPointIndex = decimalPointIndex - 1
            case 2:
                hunderthLabel.text = "0"
                self.hunderthLabel.alpha = DecimalFieldSettings.onAlpha
                decimalPointIndex = decimalPointIndex - 1
            default:
                break
        }
        
        calculate()
    }

    @IBAction func updateTipAmount(_ sender: UISegmentedControl) {
        calculate()
    }
    
    func calculate() {
        let tipPercentages = [0.18, 0.20, 0.25]
        let num1 = Double(tenthLabel.text!) ?? 0.0
        let num2 = Double(hunderthLabel.text!) ?? 0.0
        
        let decimal = num1/10 + num2/100
        let bill = Double(currentNumber) + decimal
        print(bill)
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        TotalLabel.text = String(format: "$%.2f", total)
    }
}

