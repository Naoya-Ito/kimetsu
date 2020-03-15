// 火花のエミッター
import SpriteKit
class SparkEmitterNode: SKEmitterNode {

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func makeSpark(_ lifeTime : TimeInterval) -> FireEmitterNode {
        let particle = FireEmitterNode(fileNamed: "spark")!
        particle.zPosition = 5
        particle.name = "spark"
    //        particle.xAcceleration = -30
    //        particle.yAcceleration = -40
    //    particle.setPhysic()
        particle.run(SKAction.fadeOut(withDuration: lifeTime), completion: {
            particle.removeFromParent()
        })
        return particle
    }
        
}
