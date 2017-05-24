import Foundation

public class EnhancedCanvas : Canvas {
    
    public func render(system s : VisualizedLindenmayerSystem) {
        
        render(systems: [s], generation: s.n)
        
    }
    
    public func render(systems : [VisualizedLindenmayerSystem], generation : Int) {
        
        for system in systems {
            // Verify that generation that was asked to be rendered actually exists
            var generation = generation
            if generation > system.n {
                generation = system.n
            }
            
            // Change the line length
            system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )
            
            // Render the word
            self.translate(byX: system.x, byY: system.y) // Move turtle to starting point
            for c in system.word[generation].characters {
                interpret(character: c, forThis: system)
            }
            self.translate(byX: -(system.state.penX), byY: -(system.state.penY))
            self.rotate(by: -(Degrees(system.state.axisAngle)))
        }
    }
    
    public func renderAnimated(system : VisualizedLindenmayerSystem, generation : Int) {
        
        // Verify that generation that was asked to be rendered actually exists
        var generation = generation
        if generation > system.n {
            generation = system.n
        }
        
        // Things to do at start of L-system animation...
        if system.animationPosition == 0 {
            
            // Change the line length
            system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )

            // Move turtle to starting point
            self.translate(byX: system.x, byY: system.y) // Move turtle to starting point
        }
        
        // Don't run past end of the word
        if system.animationPosition < system.word[generation].characters.count {
            
            // Get the index of the next character
            let index = system.word[generation].index(system.word[generation].startIndex, offsetBy: system.animationPosition)

            // Get the next character
            let c = system.word[generation][index]
            
            // Render the character
            interpret(character: c, forThis: system)

            // Move to next character in word
            system.animationPosition += 1

        }
        
    }
    
    func interpret(character : Character, forThis system : VisualizedLindenmayerSystem) {
        
        
        
        // Interpret each character of the word
        switch character {
        case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
            // Go forward while drawing a line
//            self.drawLine(fromX: 0, fromY: 0, toX: system.currentLength, toY: 0)
//            self.translate(byX: system.currentLength, byY: 0)
//            system.state.penX += system.currentLength
            
            let xDistance = Float(Double(system.currentLength) * Double(cos(Degrees(system.state.axisAngle))))
            let yDistance = Float(Double(system.currentLength) * Double(sin(Degrees(system.state.axisAngle))))
            
            let newPenX = system.state.penX + xDistance
            let newPenY = system.state.penY + yDistance
            
            self.drawLine(fromX: system.state.penX, fromY: system.state.penY, toX: newPenX, toY: newPenY)
            
            system.state.penX = newPenX
            system.state.penY = newPenY
            
        case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z":
            // Go forward without drawing a line
            let xDistance = Float(Double(system.currentLength) * Double(cos(Degrees(system.state.axisAngle))))
            let yDistance = Float(Double(system.currentLength) * Double(sin(Degrees(system.state.axisAngle))))
            
            let newPenX = system.state.penX + xDistance
            let newPenY = system.state.penY + yDistance
            
            self.translate(byX: xDistance, byY: yDistance)
            system.state.penX = newPenX
            system.state.penY = newPenY
            
        case "+":
            // Turn left
            self.rotate(by: system.angle)
            
            system.state.axisAngle += Int(system.angle)
            
            
        case "-":
            // Turn right
            self.rotate(by: system.angle * -1)
            system.state.axisAngle -= Int(system.angle)
            
            
        case "1", "2", "3":
            self.lineColor = Color(hue: system.colors["\(character)"]!.hue , saturation: system.colors["\(character)"]!.saturation, brightness: system.colors["\(character)"]!.brightness, alpha: 100)
            

        default:
            // Do nothing for any another character in the word
            break
        }

    }
    
}
