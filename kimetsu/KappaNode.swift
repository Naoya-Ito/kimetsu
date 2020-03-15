import Foundation
import SpriteKit

class KappaNode : SKSpriteNode {
    
    public func moveRight(){
        xScale = 1
        position.x += 5
        
    }
    
    public func moveLeft(){
        xScale = -1
        position.x -= 5
    }
    
}
