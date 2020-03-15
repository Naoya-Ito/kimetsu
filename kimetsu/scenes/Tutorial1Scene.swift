import Foundation
import SpriteKit
import GameplayKit
class Tutorial1Scene: BaseScene {

    override func sceneDidLoad() {
        commonSceneDidLoad()
        setKappa()
        addFire()
    }
    
    private func addFire(){
        let fire_light = self.childNode(withName: "//fire_light") as! SKLightNode
        let fire = FireEmitterNode.makeFire()
        fire.position = fire_light.position
        self.addChild(fire)
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            if kappa.pos <= 0 {
                kappa.moveLeftBack()
            } else {
                kappa.moveLeft()
            }
        } else {
            if kappa.pos >= Const.MAX_KAPPA_POSITION {
            } else {
                kappa.moveRight()
            }
        }
        makeHamon(pos)
    }
}
