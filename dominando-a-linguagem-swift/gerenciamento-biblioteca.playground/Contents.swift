import Foundation

enum Errors: Error {
    case bookUnavailable
}
class LibraryManager {
    private static var booksAvailable: [Int: Book] = [:]
    static private var booksLanded: [Int: Book] = [:]
    
    static func addBookToAvailable(book: Book) {
        booksAvailable[book.id] = book
    }
    
    static func hasBookWithID(_ id: Int) -> Bool {
        return booksAvailable[id] != nil
    }
    
    static func addBookToLanded(book: Book) {
        booksLanded[book.id] = book
    }
    
    static func removeBookFromAvailable(id: Int) -> Book? {
        if let removedBook = booksAvailable.removeValue(forKey: id) {
            return removedBook
        } else {
            return nil
        }
    }
    
    static func listBooks() {
        print("===== LIVROS DISPONÍVEIS =====\n")
        if !booksAvailable.isEmpty {
            for (_, book) in booksAvailable {
                print("\(book.title) (\(book.author))")
            }
            print("")
        } else {
            print("No momento, não há livros disponíveis para empréstimo.\n")
        }
        
        print("===== LIVROS EMPRESTADOS =====\n")
        if !booksLanded.isEmpty {
            for (_, book) in booksLanded {
                print("\(book.title) (\(book.author))")
            }
            print("")
        } else {
            print("No momento, não há nenhum livro a ser devolvido.\n")
        }

    }
    
    static func printDetails(forBookWithID id: Int) {
        if let availableBook = LibraryManager.booksAvailable[id] {
            availableBook.printDetails()
        } else if let landedBook = LibraryManager.booksLanded[id] {
            landedBook.printDetails()
        } else {
            print("Livro não encontrado.")
        }
    }

}


struct Book {
    let title, author, genre: String
    let id: Int
    var isLanded: Bool
    var currentUser: Student?
    
    func printDetails() {
        print("Título: \(title)\nAutor: \(author)\nID do livro: \(id)")
        if isLanded {
            print("Status: emprestado para \(currentUser?.name ?? "")")
        } else {
            print("Status: disponível")
        }
    }
}

class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func listAllBooks() {
        LibraryManager.listBooks()
    }

    func printDetails(id: Int) {
        LibraryManager.printDetails(forBookWithID: id)
    }

}

class Student: User {
    
    func borrowBook(id: Int) async throws {
           print("Aguarde enquanto estamos processando sua solicitação.\n")
           if var book = LibraryManager.removeBookFromAvailable(id: id) {
               book.isLanded = true
               book.currentUser = self
               LibraryManager.addBookToLanded(book: book)
               try await Task.sleep(until: .now + .seconds(5), clock: .continuous)
               print("Parabéns, \(name). O empréstimo do livro \(book.title) foi realizado com sucesso!\n")
           } else {
               try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
               throw Errors.bookUnavailable
           }
       }
    
}


class Teacher: User {
    
    func addBook(id: Int, title: String, author: String, genre: String) async throws {
        print("Aguarde enquanto estamos processando sua solicitação.\n")
        let newBook = Book(title: title, author: author, genre: genre, id: id, isLanded: false)
        if !LibraryManager.hasBookWithID(id) {
            LibraryManager.addBookToAvailable(book: newBook)
            try await Task.sleep(until: .now + .seconds(5), clock: .continuous)
            print("Livro \"\(newBook.title)\" adicionado com sucesso!\n")
        } else {
            try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
            print("Não é possível adicionar um livro já presente na biblioteca. Use a função \"listBooks()\" para exibir os livros já cadastrados.\n")
        }
    }
    

    func removeBook(id: Int) async throws {
        print("Aguarde enquanto estamos processando sua solicitação.\n")
        if let book = LibraryManager.removeBookFromAvailable(id: id) {
            try await Task.sleep(until: .now + .seconds(5), clock: .continuous)
            print("O livro \(book.title) foi removido da biblioteca com sucesso!\n")
        } else {
            try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
            throw Errors.bookUnavailable
        }
    }
}
