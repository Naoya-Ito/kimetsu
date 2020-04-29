import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {

    
    @IBOutlet weak var _bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAdmob()
        
        if let scene = GKScene(fileNamed: "TitleScene") {
            
            if let sceneNode = scene.rootNode as! TitleScene? {
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    view.showsPhysics = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    // kGADAdSizeBanner: 320*50
    private func setAdmob(){
        _bannerView.adUnitID = Const.ADMOB_TEST_BANNER_ID
        _bannerView.rootViewController = self
        _bannerView.delegate = self
        _bannerView.load(GADRequest())
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
