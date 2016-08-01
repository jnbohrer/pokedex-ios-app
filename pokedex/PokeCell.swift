//
//  PokeCell.swift
//  pokedex
//
//  Created by Jonathan Bohrer on 7/31/16.
//  Copyright © 2016 Jonathan Bohrer. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        name.text = self.pokemon.name.capitalizedString
        thumbnail.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
}
