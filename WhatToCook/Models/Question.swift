//
//  Question.swift
//  WhatToCook
//
//  Created by Вячеслав Квашнин on 29.03.2022.
//

import Foundation


struct Question {
    let title: String
    let type: IngredientType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Жидкости",
                type: .liquid,
                answers: [
                    Answer(title: "Вода"),
                    Answer(title: "Молоко"),
                    Answer(title: "Квас"),
                    Answer(title: "Kефир")
                ]),
            Question(
                title: "Сыпучие продукты",
                type: .bulkProducts,
                answers: [
                    Answer(title: "Гречка"),
                    Answer(title: "Рис"),
                    Answer(title: "Горох"),
                    Answer(title: "Перловка"),
                    Answer(title: "Макароны")
                ]),
            Question(
                title: "Овощи",
                type: .vegetables,
                answers: [
                    Answer(title: "Картофель"),
                    Answer(title: "Капуста"),
                    Answer(title: "Свекла"),
                    Answer(title: "Помидоры"),
                    Answer(title: "Морковь")
                ]),
            Question(
                title: "Мясо",
                type: .meat,
                answers: [
                    Answer(title: "Курица"),
                    Answer(title: "Говядина"),
                    Answer(title: "Свинина"),
                    Answer(title: "Баранина"),
                    Answer(title: "Колбаса")
                ])
        ]
    }
}

enum IngredientType {
    case liquid
    case bulkProducts
    case vegetables
    case meat
}

struct Answer {
    let title: String
}

extension IngredientType: CaseIterable { }


struct Dish {
    let dishName: String
    let recipe: String
}
