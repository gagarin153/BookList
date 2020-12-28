import Foundation

struct Article: Codable {
    let annotation: [String]
    let imagePaths: [String]
    let titles: [String]
    let name: String
    let mainImagePath: String
}
