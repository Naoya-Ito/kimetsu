// 炎のエミッター
import SpriteKit
class FireEmitterNode: SKEmitterNode {

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func makeFire() -> FireEmitterNode {
        let particle = FireEmitterNode(fileNamed: "fire")!
        particle.zPosition = 5
        particle.name = "fire"
    //        particle.xAcceleration = -30
    //        particle.yAcceleration = -40
    //    particle.setPhysic()
        return particle
    }
        
}
