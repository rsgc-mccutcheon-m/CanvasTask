import Foundation

public class LindenmayerSystem {
    
    
    
    // Set up required information
    var angle : Degrees                 // rotation amount for turtle (degrees)
    var axiom : String
    var rule : [Character : [Rule]]
    var n : Int                         // number of times the production rule is applied
    var word : [String] = []            // the word that will be rendered
    // is rendered with an animation, step by step
    
    public init(angle : Degrees,
                axiom : String,
                rule : [Character : [String]],
                generations : Int) {
        
        // Initialize stored properties
        self.angle = angle
        self.axiom = axiom
        self.rule = [:]
        self.n = generations
        self.word.append(axiom)   // The first word is the axiom
        self.rule = parseRules(raw: rule)
        
        // Apply the production rule
        applyRules()
        
    }
    
    public init(with system : LindenmayerSystem) {
        
        // Initalize stored properties
        self.angle = system.angle
        self.axiom = system.axiom
        self.rule = system.rule
        self.n = system.n
        self.word.append(axiom)   // The first word is the axiom
        
        // Apply the production rule
        applyRules()
    }
    
    func parseRules(raw: [Character : [String]]) -> [Character : [Rule]] {
        
        var oddsTotal : Int = 0
        var prevOdds  : Float  = 0
        var parsedRules : [Character : [Rule]] = [:]
        
        for (predecessor, successors) in raw {
            
            for successor in successors {
                
                if parsedRules[predecessor] != nil {
                    
                    parsedRules[predecessor]!.append(Rule(rule: successor))
                    
                } else {
                    
                    parsedRules[predecessor] = [Rule(rule: successor)]
                    
                }
                
            }
            
            
        }
        
        for (predecessor, successors) in parsedRules {
            
            for var successor in successors {
                
                oddsTotal += successor.odds
                
            }
        }
        
        for (predecessor, successors) in parsedRules {
            
            prevOdds = 0
            for var successor in successors {
                
                successor.probabillity = (Float(successor.odds) / Float(oddsTotal)) + prevOdds
                prevOdds = successor.probabillity
                
            }
        }
        
        return parsedRules
        
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
                    
                    if rule[character] != nil {
                        
                        
                        if rule[character]!.count > 1 {
                            
                            var rand =  Float(arc4random_uniform(100))/100
                        
                            for subRule in rule[character]! {
                                
                                if subRule.probabillity <= rand {
                                    
                                    newWord.append(subRule.string)
                                    
                                }
                                
                            }
                            
                        } else {
                            
                            newWord.append(rule[character]!.first!.string)
                            
                            
                        }
                        
                        // apply production rule, replace "old" F with new string
                        //newWord.append(rule[character]!)
                        
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
