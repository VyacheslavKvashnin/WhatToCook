//
//  DetailViewController.swift
//  WhatToCook
//
//  Created by Вячеслав Квашнин on 31.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var recipeLabel: UILabel!
    
    var nameDishes: [String: String] = [:]
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishNameLabel.text = Array(nameDishes)[currentIndex].key
        recipeLabel.text = Array(nameDishes)[currentIndex].value
        
    }
}
