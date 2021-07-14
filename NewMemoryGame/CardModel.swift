//
//  CardModel.swift
//  Calculator3
//
//  Created by CodewellAcademy on 4/23/19.
//  Copyright © 2019 Stefan Hristovski. All rights reserved.
//

import Foundation
class CardModel {
    //pravime model kako niza od objekti ilipovekje karti/ vo ovaj slucaj definirame prazen model ( kreiranje na array var a:[Tip na podatok] = [] - prazna niza)
    var cards:[Card] = []
    
    // funkcija koja kje go dava modelot na karti so odredena tezina (odnosno se generiraat 6 karti, potoa 12 (6*2) i na kraj 18(6*3) ) / ( sto znaci deka vo prviot model imame 12 karti , vo vtoriot 24 i vo najteshkiot model 36
    func getCards(withDifficulty int: Int){
        // Declaring an array to store generated cards/ del=klariranje na prazna niza od objekti od tip Card, vo koja kje se smestuvaat parovi generirani karti [soodvetno kako sto se generiraat vo for ciklusot podolu]
        var generatedCardsArray = [Card]()
        
        // Randomly generate pair of cards
        // edna ista karta se generira dva pati i se lepi vo praznata niza na karti
        // pr za prviot model se generiraat 6 razlicni karti , za vtoriot 12 i za tretiot 18
        for number in 1...int*6{
            
            // Creating the first card object
            let cardOne = Card()
            cardOne.imageName = "card\(number)"
            generatedCardsArray.append(cardOne)
            
            // Creating the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(number)"
            generatedCardsArray.append(cardTwo)
            
        }
        
        // Pristapuvame do praznata niza cards i gi lepime generiranite karti koi treba da se izmeshaat zatoa sto se edni do drugi [isti parovi pr generatedCardsArray = [ 1,1,2,2,3,3,4,4,5,5,6,6] (znaci imamae 12 karti koi treba da se izmeshaat)
        self.cards = generatedCardsArray //taka generiranata niza ja stavam vo pogore definiranata prazna niza

    }
    
    func getCards (){
    
        // Declaring an array to store generated cards
        var generatedCardsArray = [Card]()

        // Randomly generate pair of cards

        for number in 1...6{

            // Creating the first card object
            let cardOne = Card()
            cardOne.imageName = "card\(number)"
            generatedCardsArray.append(cardOne)

            // Creating the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(number)"
            generatedCardsArray.append(cardTwo)

        }


         self.cards = generatedCardsArray
    }
    // funkcija za random meshanje na shpil karti - edno od intervju prashanje za meshanje na shpil karti !!!!!
    func shuffleCards(){
        let i = 4 // is the mixing ratio
        // Int(arc4random_uniform(UInt32(cards.count) se generira random index vo odnos na brojot na elementi vo nizata cards
        //znaci vo card zemigo ( trgnigo ) elementot od cards so random generiraniot index , i cards.insert vmetnigo na mestoto so random generiran index
        // sto se slucuva so elementot na koj e vmetnat card ? // se pomestuva za edna pozicija vo desno The insert(at:) method shifts everything to the right of the insertion point to the right by one position!
        // func remove(at index: Int) -> Element ( znaci go brishi elementot od pozicija index, a go vrakja istiot element
        //insert(_ newElement: Element, at i: Int) - vmentnuva element na pozicija i
        for _ in 0 ..< cards.count * i {
            let card = cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
}


