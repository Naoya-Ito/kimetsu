import Foundation
import SpriteKit

class EnemyNode : SKSpriteNode {
    
    public var hp = 10
    
    // 物理属性を適用
    func setPhysic(){
        let centerPoint = CGPoint(x: 0, y: 64)
        let p_size = self.texture!.size()
        let physic = SKPhysicsBody(rectangleOf: p_size, center: centerPoint)
        physic.affectedByGravity = false
        physic.allowsRotation = true
        physic.isDynamic = true
//        physic.categoryBitMask = Const.kappaCategory
//        physic.contactTestBitMask = Const.fireCategory | Const.enemyCategory | Const.thunderCategory | Const.busterEnemyCategory
//        physic.collisionBitMask = 0
        physic.linearDamping = 0
        physic.friction = 0
        physicsBody = physic
    }
    
    
    public func rndPos() -> CGPoint {
        let pos_x = position.x + 30
        let pos_y = position.y + 10
        
        return CommonUtil.rndPos(CGPoint(x: pos_x, y: pos_y), width: 100)
    }
    
    // 吹っ飛んで消える
    public func beatAway(){
//        let vect = CGVector(dx: 1000, dy: CommonUtil.rnd(300))
        physicsBody?.allowsRotation = true
        physicsBody?.applyTorque(1.0)
//        let beatAction = SKAction.move(by: vect, duration: 0.6)
        
        let beatAction = SKAction.sequence([
            SKAction.moveBy(x: 1000.0, y: CGFloat(CommonUtil.rnd(300)), duration: 0.3),
            SKAction.removeFromParent()
        ])
        run(beatAction)
        print("beat away")
    }
    
    public func positionTop() -> CGPoint {
        let top_pos = CGPoint(x: position.x + 120, y: position.y + 160)
        
        return top_pos
    }
}
