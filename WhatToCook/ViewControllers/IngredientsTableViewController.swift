//
//  IngredientsTableViewController.swift
//  WhatToCook
//
//  Created by Kostya on 29.03.2022.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    
    @IBOutlet var questionsProgress: UIProgressView!
    
    private var ingredientIndex = 0
    private var questions = [Question]()
    private var userAnswers = [Answer]()
    private let uncheckedImage = UIImage(systemName: "circle")
    private let checkedImage = UIImage(systemName: "checkmark.circle")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appInit()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let question = getQuestion(ingredientIndex: ingredientIndex) else { return nil}
        return question.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let answers = getAnswers(ingredientIndex: ingredientIndex) else { return 0 }
        return answers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientID", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        guard let answers = getAnswers(ingredientIndex: ingredientIndex) else { return cell}
        
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
        if ingredientIndex < IngredientType.allCases.count - 1 {
            addSelectedAnswers()
            updateQuestionsProgress()
            ingredientIndex += 1
            tableView.reloadData()
        } else {
            addSelectedAnswers()
            performSegue(withIdentifier: "resultViewID", sender: nil)
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.userAnswers = userAnswers
    }
    

}
//MARK: - Private Methods
extension IngredientsTableViewController {
    private func getQuestion(ingredientIndex: Int) -> Question? {
        guard let ingredientType = getIngredientType(index: ingredientIndex) else { return nil }
        for question in questions {
            if question.type == ingredientType {
                return question
            }
        }
    return nil
    }
    
    private func getIngredientType(index: Int) -> IngredientType? {
        var currentIndex = 0
        for ingredient in IngredientType.allCases {
            if currentIndex == index {
                return ingredient
            }
            currentIndex += 1
        }
        return nil
    }
    
    private func appInit() {
        questions = Question.getQuestions()
        tableView.allowsMultipleSelection = true
        navigationItem.title = "Что готовим?"
        updateQuestionsProgress()
    }
    
    private func updateQuestionsProgress() {
        let currentProgress = questionsProgress.progress
        let newProgress = 1 / Float(IngredientType.allCases.count) + currentProgress
        questionsProgress.setProgress(newProgress, animated: true)
    }
    
    private func addSelectedAnswers() {
        guard let indexPartsForSelectedRows = tableView.indexPathsForSelectedRows else { return }
        guard let answers = getAnswers(ingredientIndex: ingredientIndex) else { return }
        for indexPart in indexPartsForSelectedRows {
            userAnswers.append(answers[indexPart.row])
        }
    }
    
    private func getAnswers(ingredientIndex: Int) -> [Answer]? {
        guard let question = getQuestion(ingredientIndex: ingredientIndex ) else { return nil }
        return question.answers
    }
}
