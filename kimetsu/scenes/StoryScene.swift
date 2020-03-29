
import Foundation
import SpriteKit
import GameplayKit
class StoryScene: BaseScene {

    public var key = ""
    
    override func sceneDidLoad() {
        commonSceneDidLoad()
    }

    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goGame(){
        if onceFlag {
            return
        }
        onceFlag = true
    }
    
    /**************************************************************************/
    /************************ touch   *****************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        makeHamon(pos)
    }
    
    override func touchUp(atPoint pos : CGPoint) {
        let tapNodes = self.nodes(at: pos)
        
        if pos.y < 100 {
            
        } else {
            // テキストを次へ
        }
    }
}
