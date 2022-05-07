//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by Owner on 2022/05/07.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var highScoreLabel: UILabel!
    
    var timer: Timer!
    var score: Int = 1000
    let defaults = UserDefaults.standard
    
    let width: CGFloat =  UIScreen.main.bounds.size.width
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    var dx: [CGFloat] = [1.0, 0.5, -1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionX = [width / 2, width / 2, width / 2]
        highScoreLabel.isHidden = true
        resultLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        start()
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(up), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func up() {
        for i in 0..<3 {
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * -1
            }
            positionX[i] += dx[i]
        }
        imgView1.center.x = positionX[0]
        imgView2.center.x = positionX[1]
        imgView3.center.x = positionX[2]
    }
    
    @IBAction func stop() {
        if timer.isValid {
            timer.invalidate()
        }
        stopButton.isHidden = true
        showResult()
        saveResult()
    }
    
    func showResult() {
        for i in 0..<3 {
            score = score - abs(Int(width / 2 - positionX[i])) * 2
        }
        resultLabel.text = "Score: \(String(score))"
        resultLabel.isHidden = false
    }
    
    func saveResult() {
        let highScore1: Int = defaults.integer(forKey: Keys.score1)
        let highScore2: Int = defaults.integer(forKey: Keys.score2)
        let highScore3: Int = defaults.integer(forKey: Keys.score3)
        
        if score > highScore3 {
            highScoreLabel.isHidden = false
        }
        
        if score > highScore1 {
            defaults.set(score, forKey: Keys.score1)
            defaults.set(highScore1, forKey: Keys.score2)
            defaults.set(highScore2, forKey: Keys.score3)
        } else if score > highScore2 {
            defaults.set(score, forKey: Keys.score2)
            defaults.set(highScore2, forKey: Keys.score3)
        } else if score > highScore3 {
            defaults.set(score, forKey: Keys.score3)
        }
        defaults.set(score, forKey: Keys.newestScore)
    }
    
    @IBAction func retry() {
        score = 1000
        positionX = [width / 2, width / 2, width / 2]
        if timer.isValid == false {
            start()
        }
        stopButton.isHidden = false
        resultLabel.isHidden = true
        highScoreLabel.isHidden = true
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
