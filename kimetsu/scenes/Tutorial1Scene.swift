import Foundation
import SpriteKit
import GameplayKit
class Tutorial1Scene: BaseScene {


    override func sceneDidLoad() {
        commonSceneDidLoad()
        setKappa()
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            if kappa.pos <= 0 {
                kappa.moveLeftBack()
            } else {
                kappa.moveLeft()
            }
        } else {
            kappa.moveRight()
        }

        makeHamon(pos)
    }
}
