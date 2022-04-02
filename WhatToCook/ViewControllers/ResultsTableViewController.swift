//
//  ResultsTableViewController.swift
//  WhatToCook
//
//  Created by Вячеслав Квашнин on 01.04.2022.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var userAnswers: [Answer] = []
    var newUserAnswers: [String] = []
    var nameDishes: [String: String] = [:]
    
    var dishes = DishesManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        getTitle()
        getCoincidences()
    }
    
    // MARK: - Privarte Methods
    
    private func getTitle() {
        for title in userAnswers {
            newUserAnswers.append(title.title)
        }
    }
    
    private func getCoincidences() {
        for item in 0 ..< newUserAnswers.count {
            for (dish, ingredient) in dishes.dishes {
                if ingredient.contains(newUserAnswers[item]) {
                    nameDishes[dish] = ingredient
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameDishes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultID", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        
        var content = cell.defaultContentConfiguration()
        let currentIndex = Array(nameDishes.keys)[indexPath.row]
        content.image = UIImage(systemName: "fork.knife.circle")
        content.text = currentIndex
        cell.contentConfiguration = content
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let currentIndex = indexPath.row
        detailVC.currentIndex = currentIndex
        detailVC.nameDishes = nameDishes
    }
}
