import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        // Пока не найдем нормальные иконок, их не будет
        let libraryVC = UINavigationController(rootViewController: LibraryViewController())
        libraryVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)

        viewControllers = [libraryVC, searchVC, profileVC]
    }

}
