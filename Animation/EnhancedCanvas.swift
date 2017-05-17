import Foundation

public class EnhancedCanvas : Canvas {
    
    public func render(system s : VisualizedLindenmayerSystem) {
        
        render(system: s, generation: s.n)
        
    }
    
    public func render(system : VisualizedLindenmayerSystem, generation : Int) {
        
        // Verify that generation that was asked to be rendered actually exists
        var generation = generation
        if generation > system.n {
            generation = system.n
        }
        
        // Change the line length
        system.currentLength = Float( Double(system.initialLength) / pow(Double(system.reduction), Double(generation)) )
        
        // Render the word
        self.saveState()
        self.translate(byX: system.x, byY: system.y) // Move turtle to starting point
        for c in system.word[generation].characters {
            interpret(character: c, forThis: system)
        }
        self.restoreState()

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
            self.drawLine(fromX: 0, fromY: 0, toX: system.currentLength, toY: 0)
            self.translate(byX: system.currentLength, byY: 0)
        case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z":
            // Go forward without drawing a line
            self.translate(byX: system.currentLength, byY: 0)
        case "+":
            // Turn left
            self.rotate(by: system.angle)
        case "-":
            // Turn right
            self.rotate(by: system.angle * -1)
            
        case "1", "2", "3":
            self.lineColor = Color(hue: system.colors["\(character)"]!.hue , saturation: system.colors["\(character)"]!.saturation, brightness: system.colors["\(character)"]!.brightness, alpha: 100)
            

        default:
            // Do nothing for any another character in the word
            break
        }

    }
    
}
