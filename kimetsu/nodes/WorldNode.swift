
import Foundation
import SpriteKit

class WorldNode : SKSpriteNode {
    
    // 物理属性を適用
    public func setPhysic(){
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size, center: CGPoint(x: 0.5, y: 0.5))
        physicsBody?.categoryBitMask = Const.worldCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
}
