//
//  ViewController.swift
//  Drake Or Nah
//
//  Created by Noora Al-Mana on 11/10/17.
//  Copyright © 2017 Noora Al-Mana. All rights reserved.
//

import UIKit
import SVProgressHUD


class ViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    
    
    var allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    var indexOfSelectedQuestion : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
            
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        updateUI()
    }
    
    // This method will update all the views on screen (progress bar, score label, etc)
    func updateUI() {
        
        progressBar.frame.size.width = (view.frame.size.width / 15) * CGFloat(questionNumber)

        progressLabel.text = String(questionNumber) + "/15"
        
        scoreLabel.text = "Score: " + String(score)
        
        nextQuestion()
    }
    
    //This method will update the question text and check if we reached the end.
    func nextQuestion() {
        
        if questionNumber <= 14 {
            
            indexOfSelectedQuestion = Int(arc4random_uniform(UInt32(allQuestions.list.count)))
            let selectedQuestion = allQuestions.list[indexOfSelectedQuestion]
            questionLabel.text = selectedQuestion.questionText
            
        }
        else {
            let alert = UIAlertController(title: "Great!", message: "You've finished all the questions. Do you want to play again?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { UIAlertAction in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    //This method will check if the user has got the right answer.
    func checkAnswer() {
        
        let selectedQuestion = allQuestions.list[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion.answer
        
        if correctAnswer == pickedAnswer {
            
            SVProgressHUD.setSuccessImage(#imageLiteral(resourceName: "progresshud-success"))
            
            SVProgressHUD.showSuccess(withStatus: "Correct!")
            SVProgressHUD.dismiss(withDelay: 0.5)
            score = score + 1
        }
            
        else {
            
            SVProgressHUD.setErrorImage(#imageLiteral(resourceName: "progresshud-error"))
            
            SVProgressHUD.showError(withStatus: "Wrong!")
            SVProgressHUD.dismiss(withDelay: 0.5)
        }
        
        allQuestions.list.remove(at: indexOfSelectedQuestion)
        
    }
    
    //This method will wipe the board clean, so that users can retake the quiz.
    func startOver() {
        
        questionNumber = 0
        score = 0
        
        allQuestions = QuestionBank()
        
        updateUI()
        
    }
    
    
    
}

