//
//  CardCollectionViewCell.swift
//  Calculator3
//
//  Created by CodewellAcademy on 4/23/19.
//  Copyright © 2019 Stefan Hristovski. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // samata custom kjelija ima predna i zadna strana
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
   
    //definiranje na objekt
    var card:Card?
    
    // postavi karta na definiraniot objekt i toa slikata postavija na frontimageview
    func setCard(_ card:Card) {
        // Keep track of the card that gets passed in
        // pristapi do promenlivata card i tuka zalepija kartata(objektot) kako vlezen parametar
        self.card = card
        frontImageView.image = UIImage(named: card.imageName)
        //na prednata strana od objektot zalepija (oberija) slikata na objektot Card so soodvetno imageName
        // ako isfliped == true togash zavrtija kartata od back na front , inaku prevrtija pak na back
        if card.isFliped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            
        }
        else{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
        
    }
    
    
    func flip() {
        if let card = card, card.isFliped{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
    }
    

    
    
}
