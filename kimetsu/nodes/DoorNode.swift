import Foundation
import SpriteKit

class DoorNode : SKSpriteNode {
    
    // 物理属性を適用
    public func setPhysic(){
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size, center: CGPoint(x: 0.5, y: 0.5))
        physicsBody?.categoryBitMask = 0
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    public func fadeAway(){
        let action = SKAction.sequence([
            SKAction.fadeOut(withDuration: 2.0),
            SKAction.removeFromParent()
        ])
    }
}
