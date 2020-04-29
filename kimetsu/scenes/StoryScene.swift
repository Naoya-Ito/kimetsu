// 会話シーン
import Foundation
import SpriteKit
import GameplayKit
class StoryScene: BaseScene {

    public var key : String = ""
    public var story : Story!

    override func sceneDidLoad() {
        commonSceneDidLoad()
    }
    
    private var didMoveOnceFlag = false
    override func didMove(to view: SKView) {
        if didMoveOnceFlag {
            return
        }
        didMoveOnceFlag = true
        story = Story(key)
        updateScene()
    }
    
    
    public func updateScene(){
        let right_image = self.childNode(withName: "//right_image") as! SKSpriteNode
        let left_image  = self.childNode(withName: "//left_image") as! SKSpriteNode
        let serihu      = self.childNode(withName: "//serihu") as! SKSpriteNode
        let text1       = self.childNode(withName: "//text1") as! SKLabelNode
        let text2       = self.childNode(withName: "//text2") as! SKLabelNode
        let text3       = self.childNode(withName: "//text3") as! SKLabelNode

        if story.right_image == "" {
            right_image.isHidden = true
        } else {
            right_image.isHidden = false
            right_image.texture = SKTexture(imageNamed: story.right_image)
            right_image.xScale = story.right_xscale
        }
        
        if story.left_image == "" {
            left_image.isHidden = true
        } else {
            left_image.isHidden = false
            left_image.texture = SKTexture(imageNamed: story.left_image)
            left_image.xScale = story.left_xscale
        }
        
        if story.talker == "left" {
            serihu.texture = SKTexture(imageNamed: "serihu_left")
        } else {
            serihu.texture = SKTexture(imageNamed: "serihu_right")
        }
        
        text1.text = story.text1
        text2.text = story.text2
        text3.text = story.text3

    }

    public func goNextPage(){
        if story.next_key == "" {
            story.loadNextPage()
            updateScene()
        } else {
            goGame()
        }
    }
    
    /**************************************************************************/
    /************************ 遷移             *****************************************/
    /**************************************************************************/
    private func goGame(){
        if onceFlag {
            return
        }
        onceFlag = true
        
        switch story.next_key {
        case "tutorial_boss":
            let nextScene = TutorialBossScene(fileNamed: "TutorialBossScene")!
            nextScene.size = self.scene!.size
            nextScene.scaleMode = SKSceneScaleMode.aspectFit
            view!.presentScene(nextScene, transition: .fade(with: .black, duration: 0.3))
        case "tutorial_clear":
            onceFlag = false
            UserDefaults.standard.set(true, forKey: "is_clear_tutorial")
            goMap()
        default:
            break
        }
    }
    
    /**************************************************************************/
    /************************ touch   *****************************************/
    /**************************************************************************/
    override func touchDown(atPoint pos : CGPoint) {
        makeHamon(pos)
    }
    
    override func touchUp(atPoint pos : CGPoint) {
//        let tapNodes = self.nodes(at: pos)
        if pos.y < 100 {
            goNextPage()
            
        }
    }
}
