import Foundation

struct Book: Codable, Equatable {
    let name: String
    let annotation: String
    let author: String
    let publicationYear: String
    let imagePath: String
    let rating: String
    let genre: String
    var id: String?
}

