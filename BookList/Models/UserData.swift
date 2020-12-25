import Foundation
import Firebase

struct UserData {
  
  let uid: String?
  let email: String?
  let name: String?
  var favoriatBooks = [Book]()
  
  init(authData: Firebase.User?) {
    self.uid = authData?.uid
    self.email = authData?.email
    self.name = authData?.displayName
    
  }
}
