import Foundation
import SpriteKit
import GameplayKit
class Tutorial1Scene: BaseScene {

    private var kappa : KappaNode = KappaNode()

    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        kappa = self.childNode(withName: "//kappa") as! KappaNode
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            kappa.moveLeft()
        } else {
            kappa.moveRight()
        }

        makeHamon(pos)
    }
}
