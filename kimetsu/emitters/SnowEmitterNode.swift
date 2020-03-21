// 雪のエミッター
import SpriteKit
class SnowEmitterNode: SKEmitterNode {

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func makeSnow() -> SnowEmitterNode {
        let particle = SnowEmitterNode(fileNamed: "snow")!
        particle.zPosition = 5
        particle.name = "snow"
    //        particle.xAcceleration = -30
    //        particle.yAcceleration = -40
    //    particle.setPhysic()
        return particle
    }
}
