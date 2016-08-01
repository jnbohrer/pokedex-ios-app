//
//  Pokemon.swift
//  pokedex
//
//  Created by Jonathan Bohrer on 7/31/16.
//  Copyright © 2016 Jonathan Bohrer. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _type: String!
    private var _description: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _nextEvoId: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._pokedexId = id
        
        self._pokemonUrl = URL_base + URL_pokemon + String(self._pokedexId) + "/"
        
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    
                    self._type = ""
                    
                    for item in types {
                        let name = item["name"]!.capitalizedString + "/"
                        self._type = self._type + name
                    }
                    
                    self._type = String(self._type.characters.dropLast())
                }
                                
                if let descArray = dict["descriptions"] as? [Dictionary<String,String>] where descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_base)\(url)")
                        Alamofire.request(.GET, nsurl!).responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in
                            
                            let desresult = response.result
                            
                            if let desdict = desresult.value as? Dictionary<String,AnyObject> {
                                if let desc = desdict["description"] as? String {
                                    self._description = desc
                                }
                            }
                            
                            completed()
                        })
                    }
                    
                } else {
                    self._description = "No description"
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        // Can't support mega pokemon right now but api still has mega data
                        if !to.lowercaseString.containsString("mega") {
                            if let evourl = evolutions[0]["resource_uri"] as? String {
                                let evoId = evourl.stringByReplacingOccurrencesOfString(URL_pokemon, withString: "")
                                
                                self._nextEvoId = String(evoId.characters.dropLast())
                                self._nextEvoTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvoTxt = "\(to) Lvl \(lvl)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}