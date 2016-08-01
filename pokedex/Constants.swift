//
//  Constants.swift
//  pokedex
//
//  Created by Jonathan Bohrer on 7/31/16.
//  Copyright © 2016 Jonathan Bohrer. All rights reserved.
//

import Foundation
import AVFoundation

let URL_base = "http://pokeapi.co"

let URL_pokemon = "/api/v1/pokemon/"

typealias DownloadComplete = () -> ()


/* Credits for images for the audio buttons:
 
 musicon.png made by Madebyoliver from www.flaticon.com
 musicoff.png made by Madebyoliver from www.flaticon.com
 
*/

var musicPlayer: AVAudioPlayer!