
import Foundation

class NetworkRequest {
    
    func doRequest (urlString: String, completion: @escaping (Result<AllCharacters, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
                if let error = error {
                    print("Some error: \(error)")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let resultOut = try JSONDecoder().decode(AllCharacters.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(resultOut))
                    }
                    
                } catch let jsonError {
                    print("ERROR!!! cant decode: ", jsonError)
                    completion(.failure(jsonError))
                }
        }.resume()
    }
    
}
