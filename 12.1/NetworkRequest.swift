
import Foundation

class NetworkRequest {
    
    func request (urlString: String, completion: @escaping (Result<AllCharacters, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error: \(error)")
                    //completion(nil, error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
//            let someString = String(data: data, encoding: .utf8)
//            print(someString)
                do {
                    let resultOut = try JSONDecoder().decode(AllCharacters.self, from: data)
                    //completion(resultOut, nil)
                    completion(.success(resultOut))
//                    print(resultOut.results.first?.name)
//                    self.ress = resultOut
//                    print(self.ress?.results.first?.name)
                } catch let jsonError {
                    print("ERROR!!! cant decode: ", jsonError)
                    //completion(nil, jsonError)
                    completion(.failure(jsonError))
                }
                
                // print(String(data: data, encoding: .utf8) ?? "no data")
           // }
            }
        }.resume()
    }
    
}
