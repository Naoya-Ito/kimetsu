// マップ画面
import SpriteKit
import GameplayKit
class MapScene: BaseScene {
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        hideNode()
    }
    
    private func hideNode(){
        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial1") {
            let shape = self.childNode(withName: "//reset_button") as? SKShapeNode
            shape?.removeFromParent()
        }
    }
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goGame(_ key : String){
        if onceFlag {
            return
        }
        onceFlag = true

        let tmp_key = key.split(separator: "-")
        let nextScene = GameScene(fileNamed: "GameScene")!
        nextScene.size = self.scene!.size
        nextScene.stage_key = String(tmp_key[1])
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
    }
    

    /**************************************************************************/
    /************************ touch   *****************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        makeHamon(pos)
    }
    
    override func touchUp(atPoint pos : CGPoint) {
        let tapNodes = self.nodes(at: pos)
        for tapNode in tapNodes {
            if let name = tapNode.name {
                if name.hasPrefix("stage-") {
                    goGame(name)
                    return
                }
                
                switch name {
                case "skill_button", "skill":
//                    resetConfirm()
                    break
                default:
                    break
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        let dt = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
    }
}
