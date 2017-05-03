//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : EnhancedCanvas
    let kochSnowflake : LindenmayerSystem
    let kochIsland : LindenmayerSystem
    let kochSwirl : LindenmayerSystem
    let kochConstruction : LindenmayerSystem
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 500, height: 500)
        
        // Set up a Koch snowflake
        kochSnowflake = LindenmayerSystem(length: 270,
                                          reduction: 3,
                                          x: 120,
                                          y: 175,
                                          direction: 0,
                                          angle: 60,
                                          axiom: "F++F++F",
                                          rule: "F-F++F-F",
                                          generations: 5)
        
        // Set up a Koch Island
        kochIsland = LindenmayerSystem(length: 300,
                                       reduction: 4,
                                       x: 100,
                                       y: 400,
                                       direction: 0,
                                       angle: 90,
                                       axiom: "F-F-F-F",
                                       rule: "F-F+F+FF-F-F+F",
                                       generations: 5)
        
        // Set up a Koch Island
        kochSwirl = LindenmayerSystem(length: 300,
                                      reduction: 3,
                                      x: 250,
                                      y: 400,
                                      direction: 0,
                                      angle: 90,
                                      axiom: "-F",
                                      rule: "F+F-F-F+F",
                                      generations: 4)

        // Set up another Koch construction
        kochConstruction = LindenmayerSystem(length: 200,
                                             reduction: 4,
                                             x: 250,
                                             y: 350,
                                             direction: 0,
                                             angle: 90,
                                             axiom: "F-F-F-F",
                                             rule: "FF-F-F-F-F-F+F",
                                             generations: 3)
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 60
        
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
                
        // Render the current system
        canvas.renderAnimated(system: kochIsland, generation: 2)
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }

}
