//
//  SystemState.swift
//  Canvas
//
//  Created by Jarvis on 2017-05-05.
//  Copyright © 2017 Royal St. George's College. All rights reserved.
//

import Foundation

public class SystemState{
    
    var axisAngle : Int
    var penY : Float
    var penX : Float
    
    public init(axisAngle: Int, penY: Float, penX: Float) {
        
        self.axisAngle = axisAngle
        self.penX = penX
        self.penY =  penY
        
    }
}
