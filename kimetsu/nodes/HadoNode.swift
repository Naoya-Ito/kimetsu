// かっぱ波動拳
import Foundation
import SpriteKit
class HadoNode : SKShapeNode {

    class func makeHado() -> HadoNode {
        let hado = HadoNode(circleOfRadius: 30)
        hado.fillColor = .yellow
        hado.strokeColor = .black
        hado.zPosition = 1
        hado.setPhysic()
        return hado
    }
    
    public func setPhysic(){
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size, center: CGPoint(x: 0.5, y: 0.5))
        physicsBody?.categoryBitMask = Const.hadoCategory
        physicsBody?.contactTestBitMask = 0
        physicsBody?.collisionBitMask = 0
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    public func shot(){
        let action = SKAction.sequence([
            SKAction.moveBy(x: 800.0, y: -20 + CGFloat(CommonUtil.rnd(320)), duration: 0.5),
            SKAction.removeFromParent()
        ])
        run(action)

        let emitter = HadoEmitterNode.makeHado()
        emitter.position = CGPoint(x: 0, y: 0)
        emitter.zPosition = 3
        addChild(emitter)
    }
    
}
