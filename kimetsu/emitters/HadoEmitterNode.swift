// 波動のエミッター
import SpriteKit
class HadoEmitterNode: SKEmitterNode {

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func makeHado() -> HadoEmitterNode {
        let particle = HadoEmitterNode(fileNamed: "magick")!
        particle.zPosition = 5
        particle.name = "hado"
    //        particle.xAcceleration = -30
    //        particle.yAcceleration = -40
    //    particle.setPhysic()
        return particle
    }
}
