//
//  SortPopViewController.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit

protocol SortPopVCDelegate {
    func reloadWithData(minYear: Int, maxYear: Int, isSortDescending: Bool)
}

class SortPopViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var fromPickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    var sortVCDelegate: SortPopVCDelegate?
    
    var selectedTextField: UITextField = UITextField()
    var yearArray:[Int] = []
    var fromYearArray:[Int] = []
    var toYearArray:[Int] = []
    var presentYear:Int!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var decoratorIcon: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var sortFirstSwithView: UISwitch!
    
    var minYear: Int!
    var maxYear: Int!
    var isSortDescending:Bool!


    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initPopUI()
    }
    
    func initData() {
        setYearsArray()
    }
    
    func initPopUI() {
        fromTextField.delegate = self
        toTextField.delegate = self
        sortFirstSwithView.setOn(isSortDescending, animated: false)
                fromPickerView.isHidden = true
        toPickerView.isHidden = true
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        decoratorIcon.layer.borderColor = UIColor.white.cgColor
        decoratorIcon.layer.borderWidth = 2
        decoratorIcon.layer.cornerRadius = decoratorIcon.frame.width/2
        decoratorIcon.layer.masksToBounds = true
        decoratorIcon.clipsToBounds = true
        closeButton.layer.cornerRadius = 2
        fromTextField.text = "\(minYear!)"
        toTextField.text = "\(maxYear!)"
        fromPickerView.reloadAllComponents()
        toPickerView.reloadAllComponents()
    }
    
    
    func setYearsArray() {
        let utils = CommonUtils()
        presentYear = utils.getCurrentYear()
        yearArray = [Int](1900...presentYear).reversed()
        fromYearArray = yearArray
        toYearArray = [Int](minYear...presentYear).reversed()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == fromPickerView {
            return fromYearArray.count
        } else if pickerView == toPickerView {
            return toYearArray.count
        }
        return 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fromPickerView {
            return "\(fromYearArray[row])"
        } else if pickerView == toPickerView {
            return "\(toYearArray[row])"
        }
        return ""
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //.hidden = true;
        if selectedTextField == fromTextField {
            pickerView.isHidden = true
            selectedTextField.text = "\(yearArray[row])"
            toYearArray = [Int](yearArray[row]...presentYear).reversed()
            toPickerView.reloadAllComponents()
        } else if selectedTextField == toTextField {
            pickerView.isHidden = true
            selectedTextField.text = "\(yearArray[row])"
            fromYearArray = [Int](1900...yearArray[row]).reversed()
            fromPickerView.reloadAllComponents()
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool  {
        if textField == fromTextField {
            fromPickerView.isHidden = false
            toPickerView.isHidden = true
            selectedTextField = fromTextField
        } else if textField == toTextField {
            toPickerView.isHidden = false
            fromPickerView.isHidden = true
            selectedTextField = toTextField
        }
        return false
    }
    
    @IBAction func closeAction(_ sender: Any) {
        if checkIfValueChanged() {
           self.sortVCDelegate?.reloadWithData(minYear: Int(fromTextField.text!)!, maxYear: Int(toTextField.text!)!, isSortDescending: sortFirstSwithView.isOn)
            self.dismiss(animated: true, completion: nil)
          print("Value changed")
            return
        } else {
            self.dismiss(animated: true, completion: nil)
            print("Value not changed")
        }
    }
    
    
    func checkIfValueChanged() -> Bool {
        if (minYear == Int(fromTextField.text!)!) && (maxYear == Int(toTextField.text!)!) && (sortFirstSwithView.isOn == isSortDescending) {
            return false
        }
        return true
    }
    
    @IBAction func sortSwitchValueChanged(_ sender: UISwitch) {
        
    }
    
    
}
