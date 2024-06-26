//
//  SetupViewController.swift
//  Coach
//
//  Created by 영현 on 6/13/24.
//

import UIKit
import SnapKit

class SetupViewController: UIViewController {
    var viewModel = SetupViewModel()
    
    var exercisePickerView = UIPickerView()
    var breaktimePickerView = UIPickerView()
    var repetitionPickerView = UIPickerView()
    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.text = "WORK"
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    let exerciseTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = ""
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 32)
        return field
    }()
    
    let breaktimeLabel: UILabel = {
        let label = UILabel()
        label.text = "REST"
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    let breaktimeTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = ""
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 32)
        return field
    }()
    
    let repetitionLabel: UILabel = {
        let label = UILabel()
        label.text = "SETS"
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    let repetitionTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = ""
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.font = .systemFont(ofSize: 32)
        return field
    }()
    
    let toolbar: UIToolbar = {
        let bar = UIToolbar()
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let confirm = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(confirmButtonTapped))
        bar.setItems([cancel, confirm], animated: true)
        bar.isUserInteractionEnabled = true
        bar.sizeToFit()
        return bar
    }()
    
    let goExerciseButton: UIButton = {
        let button = UIButton()
        button.setTitle("GO!", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 64)
        button.backgroundColor = .tintColor
        button.addTarget(self, action: #selector(goExerciseButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        exerciseTextfield.inputView = exercisePickerView
        exerciseTextfield.inputAccessoryView = toolbar
        breaktimeTextfield.inputView = breaktimePickerView
        breaktimeTextfield.inputAccessoryView = toolbar
        repetitionTextfield.inputView = repetitionPickerView
        repetitionTextfield.inputAccessoryView = toolbar
        
        exercisePickerView.delegate = self
        exercisePickerView.dataSource = self
        breaktimePickerView.delegate = self
        breaktimePickerView.dataSource = self
        repetitionPickerView.delegate = self
        repetitionPickerView.dataSource = self
        
        exercisePickerView.tag = 1
        breaktimePickerView.tag = 2
        repetitionPickerView.tag = 3
        
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(exerciseLabel)
        view.addSubview(exerciseTextfield)
        view.addSubview(breaktimeLabel)
        view.addSubview(breaktimeTextfield)
        view.addSubview(repetitionLabel)
        view.addSubview(repetitionTextfield)
        view.addSubview(goExerciseButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        if let deviceWidth = Parameters.deviceWidth, let deviceHeight = Parameters.deviceHeight {
            exerciseLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(deviceHeight * 0.1)
                $0.centerX.equalToSuperview()
            }
            exerciseTextfield.snp.makeConstraints {
                $0.width.equalTo(deviceWidth * 0.7)
                $0.height.equalTo(deviceHeight * 0.075)
                $0.top.equalTo(exerciseLabel.snp.bottom).offset(deviceHeight * 0.025)
                $0.centerX.equalToSuperview()
            }
            breaktimeLabel.snp.makeConstraints {
                $0.top.equalTo(exerciseTextfield.snp.bottom).offset(deviceHeight * 0.025)
                $0.centerX.equalToSuperview()
            }
            breaktimeTextfield.snp.makeConstraints {
                $0.width.equalTo(deviceWidth * 0.7)
                $0.height.equalTo(deviceHeight * 0.075)
                $0.top.equalTo(breaktimeLabel.snp.bottom).offset(deviceHeight * 0.025)
                $0.centerX.equalToSuperview()
            }
            repetitionLabel.snp.makeConstraints {
                $0.top.equalTo(breaktimeTextfield.snp.bottom).offset(deviceHeight * 0.025)
                $0.centerX.equalToSuperview()
            }
            repetitionTextfield.snp.makeConstraints {
                $0.width.equalTo(deviceWidth * 0.7)
                $0.height.equalTo(deviceHeight * 0.075)
                $0.top.equalTo(repetitionLabel.snp.bottom).offset(deviceHeight * 0.025)
                $0.centerX.equalToSuperview()
            }
            goExerciseButton.snp.makeConstraints {
                $0.width.equalTo(deviceWidth * 0.6)
                $0.height.equalTo(deviceHeight * 0.15)
                $0.top.equalTo(repetitionTextfield.snp.bottom).offset(deviceHeight * 0.05)
                $0.centerX.equalToSuperview()
            }
        }
    }
    
    @objc private func cancelButtonTapped() {
        exerciseTextfield.resignFirstResponder()
        breaktimeTextfield.resignFirstResponder()
        repetitionTextfield.resignFirstResponder()
    }
    
    @objc private func confirmButtonTapped() {
        if exerciseTextfield.isFirstResponder {
            if viewModel.exerciseMinutes != "0" {
                exerciseTextfield.text = "\(viewModel.exerciseMinutes)min \(viewModel.exerciseSeconds)sec"
            } else {
                exerciseTextfield.text = "\(viewModel.exerciseSeconds)sec"
            }
            exerciseTextfield.resignFirstResponder()
        } else if breaktimeTextfield.isFirstResponder {
            if viewModel.breaktimeMinutes != "0" {
                breaktimeTextfield.text = "\(viewModel.breaktimeMinutes)min \(viewModel.breaktimeSeconds)sec"
            } else {
                breaktimeTextfield.text = "\(viewModel.breaktimeSeconds)sec"
            }
            breaktimeTextfield.resignFirstResponder()
        } else if repetitionTextfield.isFirstResponder {
            repetitionTextfield.text = "\(viewModel.repetitionTimes)"
            repetitionTextfield.resignFirstResponder()
        }
    }
    
    @objc private func goExerciseButtonTapped() {
        if viewModel.isValidInput() {
            let exeView = TimerViewController()
            RoutineManager.shared.sharedRoutine = Routine(exerciseTime: viewModel.exerciseTime, breakTime: viewModel.breakTime, repetition: viewModel.reps)
            present(exeView, animated: true)
        } else {
            let alert = UIAlertController(title: "🚨Warning🚨", message: "Invalid input.\nPlease try again", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Back", style: .destructive)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
}

extension SetupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 1, 2:
            return 2
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1, 2:
            return component == 0 ? viewModel.minutes.count : viewModel.seconds.count
        case 3:
            return viewModel.repetition.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            if component == 0 {
                viewModel.exerciseMinutes = viewModel.minutes[row]
            } else {
                viewModel.exerciseSeconds = viewModel.seconds[row]
            }
        case 2:
            if component == 0 {
                viewModel.breaktimeMinutes = viewModel.minutes[row]
            } else {
                viewModel.breaktimeSeconds = viewModel.seconds[row]
            }
        case 3:
            viewModel.repetitionTimes = viewModel.repetition[row]
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1, 2:
            return component == 0 ? "\(viewModel.minutes[row])" : "\(viewModel.seconds[row])"
        case 3:
            return "\(viewModel.repetition[row])"
        default:
            return ""
        }
    }
}
