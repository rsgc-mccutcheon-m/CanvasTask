//
//  FileParser.swift
//  Canvas
//
//  Created by Jarvis on 2017-05-29.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

public class FileParser{
    
    
    
    let path : String
    
    init(path: String) {
        self.path = path
    }
    
    func parse() -> [VisualizedLindenmayerSystem] {
        guard let reader = LineReader(path: path) else {
            print("Cannot open input file \(path)")
            exit(0)
        }
        
        var components : [String] = []
        var systems: [VisualizedLindenmayerSystem] = []
        
        for (index, line) in reader.enumerated() {
            
            let lineComponents = line.components(separatedBy: " ")
            // Check to see if we have reached the end of a system
            if (lineComponents[0] == "]\n")
            {
                systems.append(initSystem(raw: components))
                components = []
            }
            // Build an array of each component from the file
            components.append(line)
        }
        return systems
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
