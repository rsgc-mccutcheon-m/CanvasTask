import Foundation

public class EnhancedCanvas : Canvas {
    
    public func render(system s : LindenmayerSystem) {
        
        // Change the line length
        let currentLength = Int( Double(s.initialLength) / pow(Double(s.reduction), Double(s.n)) )
        
        // Render the word
        self.saveState()
        self.translate(byX: s.x, byY: s.y) // Move turtle to starting point
        for character in s.word.characters {
            
            // Interpret each character of the word
            switch character {
            case "F":
                // Go forward while drawing a line
                self.drawLine(fromX: 0, fromY: 0, toX: currentLength, toY: 0)
                self.translate(byX: currentLength, byY: 0)
            case "+":
                // Turn left
                self.rotate(by: s.angle)
            case "-":
                // Turn right
                self.rotate(by: s.angle * -1)
            default:
                // Do nothing for any another character in the word
                break
            }
            
        }
        self.restoreState()
        
    }
    
}
