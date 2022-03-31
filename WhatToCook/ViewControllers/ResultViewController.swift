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
    
    var nameDishes: [String] = []
    
    let dishes: [String: String] = [
        "Куриный суп с яйцом и зеленью." : "Куриное филе, картофель, морковь, лук репчатый, вермишель, зелень петрушки, лавровый лист, соль, перец чёрный молотый, масло растительное, вода",
        "Борщ.": "Говядина, картофель, соль, капуста, свекла",
        "Картошка жаренная.": "Картофель, масло, лук, соль"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        getTitle()
        getCoincidences()
        
    }
    
    private func getTitle() {
        for title in userAnswers {
            newUserAnswers.append(title.title)
        }
        print(newUserAnswers)
    }
    
    private func getCoincidences() {
        for (dish, ingredient) in dishes {
            if ingredient.contains("картофель") {
                nameDishes.append(dish)
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
        content.text = "Cell"
        cell.contentConfiguration = content
        return cell
        
    }
}
