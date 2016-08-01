//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Jonathan Bohrer on 7/31/16.
//  Copyright © 2016 Jonathan Bohrer. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightlbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var musicBtn: UIButton!
    
    var poke: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLbl.text = poke.name.capitalizedString
        let img = UIImage(named: "\(poke.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        // download pokemon details in original VC to avoid showing placeholder data
        updateUI()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if !musicPlayer.playing {
            musicBtn.setImage(UIImage(named: "musicoff.png"), forState: .Normal)
        }
    }
    
    func updateUI() {
        descriptionLbl.text = poke.description
        typeLbl.text = poke.type
        defenseLbl.text = poke.defense
        heightLbl.text = poke.height
        pokedexLbl.text = String(poke.pokedexId)
        weightlbl.text = poke.weight
        attackLbl.text = poke.attack
        
        if poke.nextEvoId == "" {
            evoLbl.text = "No evolutions"
            nextEvoImg.hidden = true
        } else {
            evoLbl.text = "Next Evolution: " + poke.nextEvoTxt
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: poke.nextEvoId)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func musicBtnPressed(sender: UIButton!) {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.setImage(UIImage(named: "musicoff.png"), forState: .Normal)
        } else {
            musicPlayer.play()
            sender.setImage(UIImage(named: "musicon.png"), forState: .Normal)
        }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
