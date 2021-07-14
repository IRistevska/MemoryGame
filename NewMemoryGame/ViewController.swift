//
//  ViewController.swift
//  Calculator3
//
//  Created by Stefan Hristovski on 3/28/19.
//  Copyright © 2019 Stefan Hristovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
   
    

    @IBOutlet var FirstView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initTaoGestureRecognizer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // funkcija za dodavanje na recognizer koj se inicijalizira so dodavanje na akcija i target i dodavanje na taa funkcija pri prepoznavanje na dopir na bilo koe mesto na ekranot. Vo viewdidLoad se povikuva funkcijata initTapRecognizer
    func initTaoGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    // implementacija na akcija (upravuvac-handler) koj se slucuva  koga se dopira nesto na ekranot
    @objc func handleTap(){
        self.performSegue(withIdentifier: "showNextScreen", sender: nil)
    }


}

