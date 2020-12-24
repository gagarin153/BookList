import Foundation
import Firebase

struct User {
  
  let uid: String
  let email: String?
  let name: String?
  
  init(authData: Firebase.User) {
    uid = authData.uid
    email = authData.email
    name = authData.displayName
  }
  
//  init(uid: String, email: String) {
//    self.uid = uid
//    self.email = email
//  }
}
