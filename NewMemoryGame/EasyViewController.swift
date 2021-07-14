//
//  EasyViewController.swift
//  Calculator3
//
//  Created by Stefan Hristovski on 4/3/19.
//  Copyright © 2019 Stefan Hristovski. All rights reserved.
//

import UIKit

class EasyViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // deklariranje na objekt koj pretstavuva model kade kje se storiraat generirani karti
    var model = CardModel()
    
    var gameDifficult: Int?
    
    // vekje vo ovaj kontroler ni e biten parametarot gamedifficult za da ja postavime igrata so odredena tezina
    

    
    var lastFlippedCardIndex:IndexPath?
    var secondLastFlippedCardIndex:IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // funkcija za pojavuvawe na novo view
    // ako vo gamedifficult go smestime modelot so tezina koja sme ja izbrale togash na naredno view pojavigo modelot so tezinata sto sme ja izbrale , odnosno vo modelot smesti gi kartickite so izbranata tezina , odnosno vo model smesti go mozedot na generirani karti so baranata tezina
    // na kraj vo toj model izmeshaj gi kartite
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let gameDifficult = gameDifficult{
            model.getCards(withDifficulty: gameDifficult)
        }
        model.shuffleCards()
    }
    
    
    // KAKO DA IZGLEDA VIEWTO I KAKO DA SE RASPOREDAT KARTITE VO VIEWTO 
    // broj na elementi vo sekcija  i vrakja broj kolku sto ima karti vo modelot
    //tell the collection view how many cells to make
    // Odnosno so povikuvanje na ovaa metoda nie mu kazuvame na collection view kolku elementi ima vo edna sekcija , odnosno kolku custom kelii treba da se rasporedat vo collectionviewto koi se raspredeluvaat avtomatski. Collectionviewto samoto avtomatski si gi setira lokaciite na sekoja customkelija spored layout atributite posteveni od layout object.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.cards.count
        
    }
    
    //make a cell for each cell index path
    // formirame reusable element koj kje se regenerira za sekoja karta(za sekoj element) spored custom definiran vo swift file (ili klasata ) so identifier CardCell , odnosno CardCollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //// get a reference to our storyboard cell
        // vo cell sozdadi edna reusable kelija so identifier cardCell za sekoj element so lokacija index pat spored cardcollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //vo card smestuvaj go elementot od nizata cards so reden broj = lokacija vo collection view
        let card = model.cards[indexPath.row]
        
        // vo cell odnosno vo custom kelijata povikaj ja funkcijata setCard koja ja postavuva kartata (odnosno elementot) koj go smestivme vo card
        cell.setCard(card)
        
        return cell
        
    }
    
     //selektiranje na edna karta, metoda na odnesuvanje na elementite vo collectionview - element od delegate metodata = Tells the delegate that the item at the specified index path was selected.. So povikuvanje na ovaa metoda mu kazuvame na delegate objektot deka nekoja kelija e kliknata
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        // indexPath = The index path that specifies the section and item number of the cell.
        //Gets the visible cell object at the specified index path.
        //Napravigi site kelii vidlivi na soodvetna lokacija
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = model.cards[indexPath.row]
    
        // ako kartata e od stranata na slikata taa e prevrtena , povikaja funkcijata zavrti , i inicijaliziraj deka e prevrtena
        if card.isFliped == false {
            cell.flip()
            card.isFliped = true
            
            
            // ako adresata na poslednata zavrtena karta e prazno mesto , togash smesti ja indexpath (lokacijata ) , inaku vtorata zavrtena karta ja zema adresata na posledno zavrtena karta , a vo posledno zavrtena karta se smestuva novata adrsea
            // potoa sledi proveruvanje dali tie dve karti se sovpagjaat. checkformaches.ako se sovpagaat togash adresite gi inicijalizirame na nill, inaku
            if lastFlippedCardIndex == nil{
                lastFlippedCardIndex = indexPath
            }else{
                secondLastFlippedCardIndex = lastFlippedCardIndex
                lastFlippedCardIndex = indexPath
                // ako dvete karti na razlicni lokacii se isti lastFlippedCardIndex i Secondflipped cardinadex inicijalizirajgo na nula ili na prazen element , inaku
                if checkForMatches(withLastCard: lastFlippedCardIndex!, withSecondCard: secondLastFlippedCardIndex!){
                    lastFlippedCardIndex = nil
                    secondLastFlippedCardIndex = nil
                }else{
                    //ako ne izignoriraj i premini na sledno odbiranje
                    //When set to false, touch, press, keyboard, and focus events intended for the view are ignored and removed from the event queue. When set to true, events are delivered to the view normally.
                    // DispatchQueue - objekt koj upravuva so redosledno izvrshuvanje na zadacite na aplikacijata
                    collectionView.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
                        
                        // Vo card 1 pristapi do model i zemija kartata so indeks secondLastFlipedCard.row. Vo card 2 smesti ja lastFlippedCardIndex
                        let card1 = self.model.cards[self.secondLastFlippedCardIndex!.row]
                        let card2 = self.model.cards[self.lastFlippedCardIndex!.row]
                        
                        // Napravi da se prevrti kartata so soodveten index Gets the visible cell object at the specified index path
                        //Ako e odbrana kartata so index 
                        if let cellForCard2 = self.collectionView.cellForItem(at: self.secondLastFlippedCardIndex!) as? CardCollectionViewCell{
                            cellForCard2.flip()
                        }
                        cell.flip()
                        card1.isFliped = false
                        card2.isFliped = false
                        self.lastFlippedCardIndex = nil
                        self.secondLastFlippedCardIndex = nil
                        collectionView.isUserInteractionEnabled = true
                    }
                }
            }
            //TODO: - Proveri dali se matched
            
        }
    }
    
    //Funkcija za sovpagjanje na dva elementi
    // return true if matches, false otherwise
    func checkForMatches(withLastCard lastCard: IndexPath, withSecondCard seconCard: IndexPath) -> Bool{
        let card1 = model.cards[lastCard.row]
        let card2 = model.cards[seconCard.row]
        if card1.imageName == card2.imageName{
            if checkForWin(){
                print("WIN!")
                //show alert // start new game
                showAlert()
                
            }

            return true
        }
        return false
    }
    
    
    //Funkcija za pojavuvanje na alert za uspeshno zavrsheno nivo
    func showAlert()
    {
        // Klasa za konfiguriranje na alert ekran so poraka za sledna akcija. So metodata addAction pokraj porakata konfigurirame button za sledna akcija
        let alertController = UIAlertController(title: "Congratulations", message: "Proceed to next level", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
            // Put your code here
            //dismissViewControllerAnimated is used to close ViewControllers that presented using modal
            self.dismiss(animated: true, completion: nil)
        })
        // prezent na alertControllerot
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //finkcija za zavrshuvanje na igrata koja vrakja vrednost od tip Bool
    // proveruvame za sekoj element od modelot dali e na lice ili opachina
    // ako e zavrtena kartata na opacina isFliped e false , ako e na lice e true
    // najprvo proveruvame za prviot element dali e false !i (obratno). Ako najdi barem eden element so koj kje vlezi vo if ciklusot vrakja false i izleguva od ciklusot  , ako e true elementot izleguva od if cuiklusot i prodolzuva da gi izminuva drugite elementi . ako ni ednash ne vlezi vo if ciklusot a gi pomini site elementi vo for ciklusot  znaci site se na lice site se otvoreni i vrakja true vrednost , znaci igrata e zavrshena
    func checkForWin() -> Bool{
        for i in model.cards{
            if !i.isFliped{
                return false
            }
        }
        return true
    }
}


