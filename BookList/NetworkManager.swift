import Foundation
import Firebase


enum NetworkError: Error {
    case invalidURL
    case emptyData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalid url!!"
        case .emptyData:
            return "no data!!"
        }
    }
}



class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let db = Firestore.firestore()
    private let decoder = JSONDecoder()

    
    func downloadGeneralBooks(limit: Int, completion: @escaping (Result<[Book], Error>) -> ()) {
        self.db.collection("Books").limit(to: limit).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var books = [Book]()
                for  document in querySnapshot!.documents {
                    
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: document.data(), options: []) else { return}
                
                    do {
                        var book = try self.decoder.decode(Book.self, from: jsonData )
                        book.id = document.documentID
                        books.append(book)
                    } catch let error {
                        completion(.failure(error))
                    }
                }
                completion(.success(books))
            }
        }
        
    }
    
    func downloadEditorChoiceBooks(completion: @escaping (Result<[Book], Error>) -> ()) {
        self.db.collection("Editor choice").limit(to: 8).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var books = [Book]()
                let dispatchGroup = DispatchGroup()
                for document in querySnapshot!.documents {
                    dispatchGroup.enter()
                    let ref = document.get("book") as? DocumentReference
                    ref?.getDocument { (bookDocument, error) in
                        if let bookDocument = bookDocument, bookDocument.exists {
                            
                            guard let jsonData = try? JSONSerialization.data(withJSONObject: bookDocument.data() , options: []) else { return }
                            
                            do {
                                var book = try self.decoder.decode(Book.self, from:  jsonData)
                                book.id = document.documentID
                                books.append(book)
                            } catch let error {
                                completion(.failure(error))
                            }
                            dispatchGroup.leave()
                            
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    completion(.success(books))
                    
                }
            }
        }
    }
    
    
    func downloadFavoriatsBooks(for userUID: String?, completion: @escaping (Result<[Book], Error>) -> ()) {
        self.db.collection("Favoriats").document((userUID ?? " ")).addSnapshotListener({ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            }  else {
                if let querySnapshot =  querySnapshot {
                    var books = [Book]()
                    let dispatchGroup = DispatchGroup()
                    
                    
                    guard let  references = querySnapshot.get("favoriatsBook") as? [Any] else { return }
                                        
                    for (i, reference) in references.enumerated()  {
                        
                        var ref: DocumentReference
                        if i != 0 {
                             ref = reference as! DocumentReference
                        } else {
                            continue
                        }
                        dispatchGroup.enter()
                        
                        
                        ref.getDocument { (bookDocument, error) in
                            if let bookDocument = bookDocument, bookDocument.exists {
                                
                                guard let jsonData = try? JSONSerialization.data(withJSONObject: bookDocument.data() , options: []) else { return }
                                
                                do {
                                    var book = try self.decoder.decode(Book.self, from:  jsonData)
                                    book.id = bookDocument.documentID
                                    books.append(book)
                                } catch let error {
                                    completion(.failure(error))
                                }
                                dispatchGroup.leave()
                                
                            } else {
                                print("Document does not exist")
                            }
                        }
                        dispatchGroup.notify(queue: DispatchQueue.main) {
                            completion(.success(books))
                        }
                    }
                }
            }
        })

    }
}
