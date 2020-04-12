// タイトル画面
import SpriteKit
import GameplayKit

class TitleScene: BaseScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
        addSnow()
        hideReset()
    }

    private func addSnow(){
        let shape = self.childNode(withName: "//ads") as! SKSpriteNode
        let node = SnowEmitterNode.makeSnow()
        node.position = CGPoint(x: 0, y: shape.position.y - 50)
        self.addChild(node)
    }
    
    private func hideReset(){
        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial1") {
            let shape = self.childNode(withName: "//reset_button") as? SKShapeNode
            shape?.removeFromParent()
        }
    }
    
    private func resetConfirm(){
        let alert = UIAlertController(
            title: "本当にデータ削除しますか？",
            message: "一度消したデータはもう戻りません。",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "覚悟はできてる", style: .default, handler: { action in
            let appDomain = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        }))
        alert.addAction(UIAlertAction(title: "やっぱりやめる", style: .cancel))
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/

    private func goTutorial1(){
        if onceFlag {
            return
        }
        onceFlag = true
        
        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial1") {
            let nextScene = Tutorial1Scene(fileNamed: "Tutorial1Scene")!
            nextScene.size = self.scene!.size
            nextScene.scaleMode = SKSceneScaleMode.aspectFit
            view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
            return
        }
        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial2") {
            let nextScene = Tutorial2Scene(fileNamed: "Tutorial2Scene")!
            nextScene.size = self.scene!.size
            nextScene.scaleMode = SKSceneScaleMode.aspectFit
            view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
            return
        }
        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial3") {
            let nextScene = Tutorial3Scene(fileNamed: "Tutorial3Scene")!
            nextScene.size = self.scene!.size
            nextScene.scaleMode = SKSceneScaleMode.aspectFit
            view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
            return
        }
        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial4") {
            let nextScene = Tutorial4Scene(fileNamed: "Tutorial4Scene")!
            nextScene.size = self.scene!.size
            nextScene.scaleMode = SKSceneScaleMode.aspectFit
            view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
            return
        }
//        if !UserDefaults.standard.bool(forKey: "is_clear_tutorial5") {
            let nextScene = Tutorial5Scene(fileNamed: "Tutorial5Scene")!
            nextScene.size = self.scene!.size
            nextScene.scaleMode = SKSceneScaleMode.aspectFit
            view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
            return
//        }
        
        /*
        let nextScene = StoryScene(fileNamed: "StoryScene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        nextScene.key = "tutorial"
        view!.presentScene(nextScene, transition: .doorway(withDuration: 1.3))
*/
    }
    
    private func reloadScene(){
        if onceFlag {
            return
        }
        onceFlag = true

        let nextScene = TitleScene(fileNamed: "TitleScene")!
        nextScene.size = self.scene!.size
        nextScene.scaleMode = SKSceneScaleMode.aspectFit
        self.view!.presentScene(nextScene, transition: .fade(with: .white, duration: 5.0))
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
                    if !UserDefaults.standard.bool(forKey: "is_clear_tutorial") {
                        goTutorial1()
                        return
                    }
                    goMap()
                    return
                case "reset_button":
                    resetConfirm()
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
