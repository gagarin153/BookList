import Foundation

class User {
    static let shared = User()
    
    private init() {}
    
    var userData: UserData?
}
