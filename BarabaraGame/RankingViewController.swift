//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by Owner on 2022/05/07.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingLabel1: UILabel!
    @IBOutlet var rankingLabel2: UILabel!
    @IBOutlet var rankingLabel3: UILabel!
    @IBOutlet var newestScoreLabel: UILabel!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingLabel1.text = String(defaults.integer(forKey: Keys.score1))
        rankingLabel2.text = String(defaults.integer(forKey: Keys.score2))
        rankingLabel3.text = String(defaults.integer(forKey: Keys.score3))
        newestScoreLabel.text = String(defaults.integer(forKey: Keys.newestScore))
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
