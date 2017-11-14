//
//  Question.swift
//  Drake Or Nah
//
//  Created by Noora Al-Mana on 11/10/17.
//  Copyright © 2017 Noora Al-Mana. All rights reserved.
//

import Foundation

class Question {
    
    let questionText : String
    let answer : Bool
    
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
        
    }
}
