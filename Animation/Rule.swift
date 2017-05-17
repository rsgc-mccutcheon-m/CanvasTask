//
//  Rule.swift
//  Canvas
//
//  Created by Jarvis on 2017-05-11.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

public struct Rule {
    
    var string : String
    var odds : Int
    var probabillity : Float
    
    
    public init(rule: String ){
    
    
        if let components : [String] = rule.components(separatedBy: "/") {
            
            if let tempProb : Int = Int(components.first!) {
                
                self.odds = tempProb
                
            } else {
                
              
                print("failed on initializing rule \(rule)")
                exit(0)
            }
            
            if let tempString : String = components.last! {
                
                self.string = tempString
                
            } else {
                
                
                print("failed on initializing rule \(rule)")
                exit(0)
            }
            
        } else {
            
            print("failed on initializing rule \(rule)")
            exit(0)
        }
        
        self.probabillity = 0.0
        
    }
    
    mutating func getProbabillity(total: Int ) {
        
        self.probabillity = Float(self.odds) / Float(total)
        
    }
    
}
