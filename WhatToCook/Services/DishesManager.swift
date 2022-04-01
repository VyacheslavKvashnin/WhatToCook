//
//  Dishes.swift
//  WhatToCook
//
//  Created by Вячеслав Квашнин on 29.03.2022.
//

import Foundation

class DishesManager {
    
    static let shared = DishesManager()
    
    let dishes: [String: String] = [
        "Куриный суп с яйцом и зеленью" : "Куриное филе, картофель, морковь, лук репчатый, вермишель, вода",
        "Борщ": "Говядина, картофель, соль, капуста, свекла",
        "Картошка жаренная": "Картофель, масло, лук, соль",
        "Гороховый суп" : "Горох, картофель, колбаса."
    ]
    
    private init() {}
}
