//
//  Employee.swift
//  SwiftLab2
//
//  Created by Bayoumi on 15/04/2026.
//

import Foundation

class Employee : Person{
    
    override init(salary: Double) {
        super.init(salary: salary * 1.2)
    }
}
