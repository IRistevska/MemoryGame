//
//  EasyMediumHardViewController.swift
//  NewMemoryGame
//
//  Created by CodewellAcademy on 4/24/19.
//  Copyright © 2019 CodewellAcademy. All rights reserved.
//

import UIKit

class EasyMediumHardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var gameDifficult = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// postavuvame action na buttons i vikame ako e stisnato kopceto easy togash gamedifficult=1, istoto go pravime i so drugite kopchinja 
    @IBAction func easyTapped(_ sender: Any) {
        gameDifficult = 1
    }
    
    @IBAction func mediumTapped(_ sender: Any) {
        gameDifficult = 2
    }
    
    @IBAction func hardTapped(_ sender: Any) {
        gameDifficult = 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ако во цонтролер го сместиме сегуето со дестинација до easyviewcontroller togash na taa destinacija smesti ja igrata so tezina gameDifficult koja zema vrednost od kopceto koe e stisnato
        // ako e stisnato bilo koe kopce koe ne nosi do easyviewControler togash zemija vrednosta na gamedifficult i stavija vo pogore definiranata promenliva gamedifficult za da znaeme za koj model stanuva zbor 
        if let controller = segue.destination as? EasyViewController {
            controller.gameDifficult = self.gameDifficult
        }
    }
}
