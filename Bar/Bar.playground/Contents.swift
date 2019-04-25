//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Bar

class MyViewController : UIViewController {
    
    var tabBar: Bar!
    
    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = .white
        
        tabBar = Bar(frame: .zero)
//        tabBar.backgroundColor = UIColor.orange
//        tabView.tintColor = .white
//
        view.addSubview(tabBar)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1 = Bar.Tab(image: UIImage(named: "hammer"), title: "11111111111111111111111111")
        let tab2 = Bar.Tab(image: UIImage(named: "hammer"), title: "222")
        let tab3 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        
        tabBar.add(items: [tab1, tab2, tab3])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
