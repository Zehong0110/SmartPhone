//
//  ViewController.swift
//  Cardgame
//
//  Created by 沈泽洪 on 9/27/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var card1: UIImageView!
    
    @IBOutlet weak var card2: UIImageView!
    
    @IBOutlet weak var card3: UIImageView!
    
    @IBOutlet weak var card4: UIImageView!
    
    @IBOutlet weak var card5: UIImageView!
    
    @IBOutlet weak var card6: UIImageView!
    
    @IBOutlet weak var winerlabel: UILabel!
    
    let imageNames=["AS", "AC","AD","AH",
                    "2S", "2C", "2D","2H",
                    "3S", "3C", "3D","3H",
                    "4S", "4C", "4D","4H",
                    "5S", "5C", "5D","5H",
                    "6S", "6C", "6D","6H",
                    "7S", "7C", "7D","8H",
                    "8S", "8C", "8D","8H",
                    "9S", "9C", "9D","9H",
                    "10S", "10C", "10D","10H",
                    "JS", "JC", "JD","JH",
                    "QS", "QC", "QD","QH",
                    "KS", "KC", "KD","KH",
                    ]
    
    func uniqueRandoms(_ numberOfRandoms: Int,  _ minNum: Int,  _ maxNum: UInt32) -> [Int] {
        var uniqueNumbers = Set<Int>()
        while uniqueNumbers.count < numberOfRandoms {
            uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
        }
        return uniqueNumbers.shuffled()
    }
    
    func shuffleCards(){
        //print(uniqueRandoms(6,0,9)[0])
        let sixNums: [Int] = uniqueRandoms(6,0,51)
        
        let val1=sixNums[0]
        
        let val2=sixNums[1]
        
        let val3=sixNums[2]
        
        let val4=sixNums[3]
        
        let val5=sixNums[4]
        
        let val6=sixNums[5]
        
        card1.image = UIImage(named:imageNames[val1])
        card2.image=UIImage(named: imageNames[val2])
        card3.image=UIImage(named:imageNames[val3])
        card4.image=UIImage(named:imageNames[val4])
        card5.image=UIImage(named:imageNames[val5])
        card6.image=UIImage(named:imageNames[val6])
        
        if imageNames[val1].isEqual("AS") || imageNames[val2].isEqual("AS") || imageNames[val3].isEqual("AS"){
            winerlabel.text="Play 1 is a winner"
            prompt()
        }
        
        else if (imageNames[val4].isEqual("AS") || imageNames[val5].isEqual("AS") || imageNames[val6].isEqual("AS")){
            winerlabel.text="Play 2 is a winner"
            prompt()
        }
        
        else {
            winerlabel.text="No winner"   
            
        }
        
    }
    
    
    func prompt() {
        let alert = UIAlertController(title: "Play Again ?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert:UIAlertAction!) in self.shuffleCards()}))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playbutton(_ sender: Any) {
        shuffleCards()
    }
    
}

