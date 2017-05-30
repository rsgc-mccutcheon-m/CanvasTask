//
//  FileParser.swift
//  Canvas
//
//  Created by Mark McCutcheon on 2017-05-29.
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
    
    func initSystem(raw : [String]) -> VisualizedLindenmayerSystem {
        var axiom : String = ""
        var rules : [Character : [String]] = [:]
        var generations : Int = 0
        var length : Float = 0
        var reduction : Float = 0
        var x : Float = 0
        var y : Float = 0
        var direction : Int = 0
        var thickness : Float = 1
        var angle : Float = 0
        var tReduction: Float = 1
        var colorList : [String : LineColor] = [:]
        
        //create a dictionary of header : value pairs for each useful line in the file.
        for (index, line) in raw.enumerated() {
            
            //get rid of /n char, then split on the colon and ditch it.
            var splitLine = line.components(separatedBy: "\n")[0].components(separatedBy: ":")
            
            //for the header, check what it is and then set the system value it defines
            switch splitLine[0] {
                
                
            case "angle":
                angle = Float(splitLine[1])!
                break
                
            case "axiom":
                axiom = splitLine[1]
                break
                
            case "rules":
                var incIndex = index + 2
                //so long as youre within the rules array and not at the end.
                while raw[incIndex].components(separatedBy: "\n")[0].characters[raw[incIndex].components(separatedBy: "\n")[0].characters.startIndex] != "}" {
                    var rule = raw[incIndex].components(separatedBy: "\n")[0].components(separatedBy: "=")
                    var predecessor = Character(rule.first!)
                    var rawRule = rule.last!
                    if rules[predecessor] != nil {
                    rules[predecessor]!.append(rawRule)
                    } else {
                    rules[predecessor] = [rawRule]
                    }
                    incIndex += 1
                }
                break
                
            case "direction":
                direction = Int(splitLine[1])!
                break
                
            case "generations":
                generations = Int(splitLine[1])!
                break
                
            case "length":
                length = Float(splitLine[1])!
                break
                
            case "length_reduction":
                reduction = Float(splitLine[1])!
                break
                
            case "thickness_reduction":
                tReduction = Float(splitLine[1])!
                break
                
            case "thickness":
                thickness = Float(splitLine[1])!
                break
                
            case "x":
                x = Float(splitLine[1])!
                break
                
            case "y":
                y = Float(splitLine[1])!
                break
                
            case "colors":
                var _index = index + 2
                while raw[_index].components(separatedBy: "\n")[0].characters[raw[_index].components(separatedBy: "\n")[0].characters.startIndex] != "}" {
                    var color = raw[_index].components(separatedBy: "\n")[0].components(separatedBy: "=")
                    let temp1 = Float(Int(color[1].components(separatedBy: ",")[0])!)
                    let temp2 = Float(Int(color[1].components(separatedBy: ",")[1])!)
                    let temp3 = Float(Int(color[1].components(separatedBy: ",")[2])!)
                    let tempColor = LineColor(hue: temp1, saturation: temp2, brightness: temp3)
                    let indexChar : String = String(color[0].characters[color[0].characters.startIndex])
                    colorList[indexChar]=tempColor
                    _index += 1
                }
                break
                
            default:
                break
            }
            
        }
        let outputSystem : LindenmayerSystem = LindenmayerSystem(angle: angle, axiom: axiom, rule: rules, generations: generations)
        
        return VisualizedLindenmayerSystem(with: outputSystem, thickness: thickness, thickReduction: tReduction, length: length, reduction: reduction, x: Int(x), y: Int(y), direction: direction, colours: colorList)
    }

    
    
    
    
    
    
    
    
    
    
    
}
