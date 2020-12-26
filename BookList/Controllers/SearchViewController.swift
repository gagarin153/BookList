import UIKit
import Firebase

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
        let db = Firestore.firestore()

        
        db.collection("Favoriats").document((User.shared.userData?.uid)!).updateData([
            "favoriatsBook": FieldValue.arrayRemove([db.document("/Books/30zoFV4ofvrL3olt0gVC")])
        ])
    }
}
