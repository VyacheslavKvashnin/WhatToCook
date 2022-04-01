//
//  ResultViewController.swift
//  WhatToCook
//
//  Created by Вячеслав Квашнин on 31.03.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var userAnswers: [Answer] = []
    var newUserAnswers: [String] = []
    
    var nameDishes: [String: String] = [:]
    
    let dishes: [String: String] = [
        "Куриный суп с яйцом и зеленью." : "Куриное филе, картофель, морковь, лук репчатый, вермишель, вода",
        "Борщ.": "Говядина, картофель, соль, капуста, свекла",
        "Картошка жаренная.": "Картофель, масло, лук, соль",
        "Гороховый суп." : "Горох, картофель, колбаса."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        getTitle()
        getCoincidences()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        detailVC.nameDishes = nameDishes
        
    }
    
    private func getTitle() {
        for title in userAnswers {
            newUserAnswers.append(title.title)
        }
    }
    
    private func getCoincidences() {
        for item in 0 ..< newUserAnswers.count {
            for (dish, ingredient) in dishes {
                if ingredient.contains(newUserAnswers[item]) {
                    nameDishes[dish] = ingredient
                }
            }
        }
    }
}

extension ResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultID", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let currentIndex = Array(nameDishes.keys)[indexPath.row]
        
        content.text = currentIndex
        cell.contentConfiguration = content
        return cell
        
    }
}
