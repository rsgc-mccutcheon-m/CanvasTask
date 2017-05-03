//
//  ViewController.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var timer = Timer()
    var sketch = Sketch()
    
    @IBOutlet var myView: NSView!
    
    override func mouseDown(with theEvent: NSEvent) {
        
        // Set the mouseX and mouseY values on the canvas
        sketch.canvas.mouseX = Float(theEvent.locationInWindow.x)
        sketch.canvas.mouseY = Float(theEvent.locationInWindow.y)
        
        // Call the mouseDown function on the canvas, but only if it exists
        if sketch.responds(to: Selector(("mouseDown"))) {
            sketch.mouseDown()
        }
        
    }
    
    override func keyDown(with theEvent: NSEvent) {
        print("Key Pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tell OS that we want a layer to display an image on
        self.view.wantsLayer = true
        
        // We want to accept keyboard events
        //        self.view.window
        
        // Initialize the timer used to drive the sketch
        timer = Timer.scheduledTimer(timeInterval: 1/Double(sketch.canvas.framesPerSecond), target: self, selector: #selector(ViewController.timedDraw), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Before the view appears, resize to match the size of the canvas we are painting on
        // See: http://stackoverflow.com/questions/27578085/resizing-window-to-view-controller-size-in-storyboard
        preferredContentSize = NSSize(width: sketch.canvas.width, height: sketch.canvas.height)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func timedDraw() {
        
        // Call the draw() method on the Sketch object
        sketch.draw()
        
        // Increment the frame count for the current canvas of the sketch
        sketch.canvas.frameCount += 1
        
        // Get a Core Graphics representation of the current image on the canvas
        var imageRect : NSRect = NSMakeRect(0, 0, CGFloat(sketch.canvas.width), CGFloat(sketch.canvas.height))
        
        // Get a new graphics context based on what's happened with the canvas in the last draw() loop
        NSGraphicsContext.setCurrent(NSGraphicsContext(bitmapImageRep: sketch.canvas.offscreenRepresentation))
        
        // Update the view (set it to the backing layer of the NSView object tied to the view controller)
        self.view.layer!.contents = sketch.canvas.imageView.image?.cgImage(forProposedRect: &imageRect, context: NSGraphicsContext.current(), hints: nil)
        
        // Restore any transformations on the new graphics context so that next draw() loop carries on where it left off
        for transform in sketch.canvas.transforms {
            
            // If this transformation is a rotation, apply it...
            if let rotation = transform as? Rotation {
                let xform = NSAffineTransform()
                xform.rotate(byDegrees: rotation.amount)
                xform.concat()
            }

            // If this transformation is a translation, apply it...
            if let translation = transform as? Translation {
                let xform = NSAffineTransform()
                xform.translateX(by: CGFloat(translation.x), yBy: CGFloat(translation.y))
                xform.concat()
            }
            
            // If this transformation is a state change, apply it...
            if let stateChange = transform as? StateChange {
                if stateChange.save {
                    NSGraphicsContext.saveGraphicsState()
                } else {
                    NSGraphicsContext.restoreGraphicsState()
                }
            }

        }
        
    }
    
    
    
}

