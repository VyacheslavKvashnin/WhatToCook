//
//  IngredientsTableViewController.swift
//  WhatToCook
//
//  Created by Kostya on 29.03.2022.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    private var ingredientIndex = 0
    private var questions: [Question]!
    private let uncheckedImage = UIImage(systemName: "circle")
    private let checkedImage = UIImage(systemName: "checkmark.circle")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = Question.getQuestions()
        tableView.allowsMultipleSelection = true
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredientType = getIngredientType(forIndex: ingredientIndex) else { return 0 }
        if let question = getQuestion(for: ingredientType) {
            return question.answers.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientID", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        guard let ingredientType = getIngredientType(forIndex: ingredientIndex) else { return cell }
        guard let question = getQuestion(for: ingredientType ) else { return cell }
        let answers = question.answers
        
        cell.accessoryView = UIImageView(image: uncheckedImage)
        cellContent.text = answers[indexPath.row].title
        cell.contentConfiguration = cellContent
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryView = UIImageView(image: checkedImage)
        
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryView = UIImageView(image: uncheckedImage)
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        let ingredientCount = IngredientType.allCases.count
        if ingredientIndex < ingredientCount {
            ingredientIndex += 1
            navigationItem.title = "Вопрос \(ingredientIndex+1) из \(ingredientCount)"
            
        } else {
            
        }
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - Private Methods
extension IngredientsTableViewController {
    private func getQuestion(for ingredientType: IngredientType) -> Question? {
        for question in questions {
            if question.type == ingredientType {
                return question
            }
        }
    return nil
    }
    
    private func getIngredientType(forIndex index: Int) -> IngredientType? {
        var currentIndex = 0
        for ingredient in IngredientType.allCases {
            if currentIndex == index {
                return ingredient
            }
            currentIndex += 1
        }
        return nil
    }
}
