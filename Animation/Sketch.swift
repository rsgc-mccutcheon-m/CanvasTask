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

    
    
    // Create the basic L-systems
    let kochSnowflake : LindenmayerSystem
    let kochIsland : LindenmayerSystem
    let kochSwirl : LindenmayerSystem
    let kochConstruction : LindenmayerSystem
    
    // Create the visualizations of the snowflake
    let smallKochSnowflake : VisualizedLindenmayerSystem
    let mediumKochSnowflake : VisualizedLindenmayerSystem
    
    // Create visualizations of other systems
    let largeKochIsland : VisualizedLindenmayerSystem
    let mediumKochSwirl : VisualizedLindenmayerSystem
    let mediumConstruction : VisualizedLindenmayerSystem
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create a new canvas
        canvas = EnhancedCanvas(width: 500, height: 500)
        
        // Set up a Koch snowflake
        kochSnowflake = LindenmayerSystem(angle: 60,
                                          axiom: "F++F++F",
                                          rule: "F-F++F-F",
                                          generations: 5)
        
        // Visualize this as a small snowflake
        smallKochSnowflake = VisualizedLindenmayerSystem(with: kochSnowflake,
                                                         length: 90,
                                                         reduction: 3,
                                                         x: 120,
                                                         y: 175,
                                                         direction: 0)
        
        // Visualize this as a small snowflake
        mediumKochSnowflake = VisualizedLindenmayerSystem(with: kochSnowflake,
                                                          length: 270,
                                                          reduction: 3,
                                                          x: 250,
                                                          y: 300,
                                                          direction: 0)
        
        
        // Set up a Koch Island
        kochIsland = LindenmayerSystem(angle: 90,
                                       axiom: "1F-2F-3F-1F",
                                       rule: "1F-F+2F+F3F-F-1F+F",
                                       generations: 5)
        
        // Visualize the Koch Island
        largeKochIsland = VisualizedLindenmayerSystem(with: kochIsland,
                                                       length: 300,
                                                       reduction: 4,
                                                       x: 100,
                                                       y: 400,
                                                       direction: 10,
                                                       colours: ["1" : LineColor(hue: 140, saturation: 10, brightness: 10),
                                                                 "2" : LineColor(hue: 150, saturation: 50, brightness: 80),
                                                                 "3" : LineColor(hue: 160, saturation: 70, brightness: 90)]
                                                        )
        
        // Set up a Koch Swirl
        kochSwirl = LindenmayerSystem(angle: 90,
                                      axiom: "-F",
                                      rule: "F+F-F-F+F",
                                      generations: 4)
        
        // Visualize the Koch Swirl
        mediumKochSwirl = VisualizedLindenmayerSystem(with: kochSwirl,
                                                      length: 300,
                                                      reduction: 3,
                                                      x: 250,
                                                      y: 400,
                                                      direction: 0)

        // Set up another Koch construction
        kochConstruction = LindenmayerSystem(angle: 90,
                                             axiom: "F-F-F-F",
                                             rule: "FF-F-F-F-F-F+F",
                                             generations: 3)
        
        // Visualize this other Koch construction
        mediumConstruction = VisualizedLindenmayerSystem(with: kochConstruction,
                                                         length: 200,
                                                         reduction: 4,
                                                         x: 250,
                                                         y: 350,
                                                         direction: 0)
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 60
        
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
        
//        // Clear the screen
//        canvas.fillColor = Color.white
//        canvas.drawRectangle(bottomLeftX: 0, bottomLeftY: 0, width: canvas.width, height: canvas.height)
//        
//        // Render each generation step by step
//        canvas.render(system: smallKochSnowflake, generation: canvas.frameCount)
        print(canvas.frameCount)
        
        // Render the current system
        canvas.renderAnimated(system: largeKochIsland, generation: 4)
        //canvas.renderAnimated(system: smallKochSnowflake, generation: 5)
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }
    
}
