//
//  Player.swift
//  NGM-AXA-SopraSteria
//
//  Created by Nacho González Miró on 26/6/18.
//  Copyright © 2018 Nacho MAC. All rights reserved.
//

import Foundation

struct Player {
    
    var name: String!
    var thumbnail: String!
    var hairColor: String!
    var age: Int32!
    var height: Double!
    var weight: Double!
    var friends: NSArray!
    var professions: NSArray!
    
    init(name: String, thumbnail: String, age: Int32, hairColor: String, height: Double, weight: Double, friends: NSArray, professions: NSArray) {
        self.name = name
        self.thumbnail = thumbnail
        self.age = age
        self.hairColor = hairColor
        self.height = height
        self.weight = weight
        self.friends = friends
        self.professions = professions
    }
}
