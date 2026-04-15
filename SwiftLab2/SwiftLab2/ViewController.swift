//
//  ViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var salaryTextField: UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resultLabel.text = "Enter Salary and choose your role"
    }

    @IBAction func createManagerTapped(_ sender: UIButton) {
        guard let text = salaryTextField.text , let salary = Double(text) else {
            resultLabel.text = "Please enter a valid salary"
            return
            }
        let manager = Manager(salary: salary)
        resultLabel.text = "Manager Salary is \(manager.salary)"
        }
        
    
    @IBAction func createEmployeeTapped(_ sender: UIButton) {
        guard let text = salaryTextField.text , let salary = Double(text) else {
            resultLabel.text = "Please enter a valid salary"
            return
            }
        let employee = Employee(salary: salary)
        resultLabel.text = "Employee Salary is \(employee.salary)"
        
    }
    @IBAction func navigateToTask2(_ sender: UIButton) {
     
        let moviesVC = storyboard?.instantiateViewController(withIdentifier: "MoviesTableViewController")as! MoviesTableViewController
        
            navigationController?.pushViewController(moviesVC, animated: true)
    }
}

