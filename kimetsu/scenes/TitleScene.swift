// タイトル画面
import SpriteKit
import GameplayKit

class TitleScene: BaseScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        addSnow()
    }

    private func addSnow(){
        let shape = self.childNode(withName: "//ads") as! SKSpriteNode
        let node = SnowEmitterNode.makeSnow()
        node.position = CGPoint(x: 0, y: shape.position.y - 100)
        self.addChild(node)
    }
    
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goGame(){
        if onceFlag {
            return
        }
        onceFlag = true

        let nextScene = GameScene(fileNamed: "GameScene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
    }
    
    private func goTutorial1(){
        if onceFlag {
            return
        }
        onceFlag = true

        let nextScene = Tutorial1Scene(fileNamed: "Tutorial1Scene")!
        nextScene.size = self.scene!.size
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
                switch name {
                case "start_button":
                    if !UserDefaults.standard.bool(forKey: "is_clear_tutorial1") {
                        goTutorial1()
                        return
                    }
                    
                    goGame()
                    return
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
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        self.lastUpdateTime = currentTime
    }
}
