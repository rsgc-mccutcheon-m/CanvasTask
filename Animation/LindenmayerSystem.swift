import Foundation

public class LindenmayerSystem {
    // Set up required information
    var initialLength : Float           // initial line segment length
    var currentLength : Float           // current line segment length
    var reduction : Float               // reduction factor
    var x : Int                         // initial horizontal position of turtle
    var y : Int                         // initial vertical position of turtle
    var direction : Int                 // initial direction turtle faces (degrees)
    var angle : Degrees                 // rotation amount for turtle (degrees)
    var axiom : String
    var rule : String
    var n : Int                         // number of times the production rule is applied
    var word : [String] = []            // the word that will be rendered
    var animationPosition = 0           // tracks current character being interpreted when
                                        // Lindenmayer system is rendered with an animation, step by step
    
    public init(length : Float,
                reduction : Float,
                x : Int,
                y : Int,
                direction : Int,
                angle : Degrees,
                axiom : String,
                rule : String,
                generations : Int) {
        
        // Initialize stored properties
        initialLength = length
        currentLength = initialLength
        self.reduction = reduction
        self.x = x
        self.y = y
        self.direction = direction
        self.angle = angle
        self.axiom = axiom
        self.rule = rule
        self.n = generations
        self.word.append(axiom)   // The first word is the axiom
        
        // Apply the production rule
        applyRules()
        
    }
    
    func applyRules() {
        
        // See if word needs to be re-written
        if n > 0 {
            
            // Apply the production rule "n" times
            for i in 1...n {
                
                // Create a new word
                var newWord = ""
                
                // Inspect each character of existing word
                for character in word[i - 1].characters {
                    
                    if character == "F" {
                        
                        // apply production rule, replace "old" F with new string
                        newWord.append(rule)
                        
                    } else {
                        
                        // just copy what's in the existing word to the new word
                        newWord.append(character)
                        
                    }
                    
                }
                
                // Add the re-written word to the system
                word.append(newWord)
                
            }
            
        }
        
    }
    
}
