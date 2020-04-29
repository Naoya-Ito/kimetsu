import Foundation
import SpriteKit

class CircleNode : SKShapeNode {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fillColor: SKColor) {
        self.init(circleOfRadius: 100)
        self.fillColor = fillColor
        strokeColor = .gray
        zPosition = 99
        alpha = 0.0
        lineWidth = 3
    }
    
    public func setCircle(_ pos : CGPoint){
        alpha = 1.0
        setScale(0.01)
        position = pos
    }
    
    public func fadeOut(){
        let fadeAction = SKAction.fadeOut(withDuration: 0.2)
        run(fadeAction)
    }
}
