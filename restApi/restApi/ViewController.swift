//
//  ViewController.swift
//  restApi
//
//  Created by Ксения Чепурных on 25.04.2022.
//

import UIKit

enum Price: String, CaseIterable {
    case cheep = "$"
    case medium = "$$"
    case expensive = "$$$"
}

class ViewController: UIViewController {

    @IBOutlet weak var getActivityButton: UIButton!
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var participantsView: UIView!
    @IBOutlet weak var activityTypeTextField: UITextField!
    @IBOutlet weak var activityTypeView: UIView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var priceView: UIView!

    private var isActivityEditing: Bool = false
    private let prices = Price.allCases
    private let activityTypes = [
        "Education",
        "Recreational",
        "Social",
        "DIY",
        "Charity",
        "Cooking",
        "Relaxation",
        "Music",
        "Busywork"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        configureUnderViews()
        configureTextFields()
    }

    @IBAction func getActivity(_ sender: Any) {
        var minPrice: Double = 0
        var maxPrice: Double = 0

        if let price = Price(rawValue: priceTextField.text ?? "") {
            switch price {
            case .cheep:
                minPrice = 0
                maxPrice = 0.3
            case .medium:
                minPrice = 0.3
                maxPrice = 0.6
            case .expensive:
                minPrice = 0.6
                maxPrice = 1
            }
        }
        
        let activity = Activity(
            participants: participantsTextField.text,
            type: activityTypeTextField.text?.lowercased(),
            minprice: String(minPrice),
            maxprice: minPrice == maxPrice ? nil : String(maxPrice)
        )
        ActivityService.shared.getActivities(activity: activity) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let activityVC = storyBoard.instantiateViewController(withIdentifier: "activityViewController") as? ActivityViewController
                activityVC?.configure(with: result.activity)
                self?.present(activityVC ?? UIViewController(), animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == activityTypeTextField {
            isActivityEditing = true
        }

        if textField == priceTextField {
            isActivityEditing = false
        }
    }

}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        isActivityEditing ? activityTypes.count : prices.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        isActivityEditing ? activityTypes[row] : prices[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        isActivityEditing ? (activityTypeTextField.text = activityTypes[row]) : (priceTextField.text = prices[row].rawValue)
    }
    
}

// MARK: - Private Methods

private extension ViewController {

    func configureButton() {
        getActivityButton.layer.cornerRadius = 10
    }

    func configureUnderViews() {
        participantsView.layer.cornerRadius = 10
        activityTypeView.layer.cornerRadius = 10
        priceView.layer.cornerRadius = 10
    }

    func configureTextFields() {
        participantsTextField.layer.masksToBounds = true
        participantsTextField.layer.cornerRadius = 5
        participantsTextField.delegate = self

        activityTypeTextField.layer.masksToBounds = true
        activityTypeTextField.layer.cornerRadius = 5
        activityTypeTextField.delegate = self

        priceTextField.layer.masksToBounds = true
        priceTextField.layer.cornerRadius = 5
        priceTextField.delegate = self

        let activityPickerView = UIPickerView()
        activityPickerView.delegate = self
        activityPickerView.dataSource = self
        activityTypeTextField.inputView = activityPickerView
        
        let pricePickerView = UIPickerView()
        pricePickerView.delegate = self
        pricePickerView.dataSource = self
        priceTextField.inputView = pricePickerView
    }

}

