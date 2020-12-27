import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = .black
        self.setUpTabBar()
    }
    
    func setUpTabBar() {
        let libraryVC = UINavigationController(rootViewController: LibraryViewController())
        libraryVC.tabBarItem = UITabBarItem(title: "Библиотека", image: UIImage(systemName: "book.fill"), tag: 1)
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle.fill"), tag: 3)

        self.viewControllers = [libraryVC, searchVC, profileVC]
    }

}
