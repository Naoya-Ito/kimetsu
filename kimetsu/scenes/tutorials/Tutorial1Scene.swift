import Foundation
import SpriteKit
import GameplayKit
class Tutorial1Scene: BaseScene {

    override func sceneDidLoad() {
        commonSceneDidLoad()
        setKappa()
        setWorld()
        addFire()
    }
    
    private func addFire(){
        let fire_light = self.childNode(withName: "//fire_light") as! SKLightNode
        let fire = FireEmitterNode.makeFire()
        fire.position = fire_light.position
        self.addChild(fire)
    }
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goNextTutorial(){
        if onceFlag {
            return
        }
        onceFlag = true

        let nextScene = Tutorial2Scene(fileNamed: "Tutorial2Scene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
    }

    /**************************************************************************/
    /************************ tap             ******************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        if pos.x < 0 {
            if kappa.pos <= 0 {
                kappa.moveLeftBack()
            } else {
                kappa.moveLeft()
            }
        } else {
            if kappa.pos >= Const.MAX_KAPPA_POSITION {
                goNextTutorial()
            } else {
                kappa.moveRight()
            }
        }
        makeHamon(pos)
    }
}
