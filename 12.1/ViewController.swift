import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let networkRequest = NetworkRequest()
    var result: AllCharacters? = nil
    // let urlString = "https://icodeschool.ru/json1.php"
    //let urlString2 = "https://rickandmortyapi.com/api/character/149"
    let urlString3 = "https://rickandmortyapi.com/api/character"
    
    //    func doRequest(){
    //        AF.request(urlString3).responseJSON { response in
    //            DispatchQueue.main.async {
    //                guard let data = response.data else { return }
    //                do {
    //                    let res: AllCharacters = try JSONDecoder().decode(AllCharacters.self, from: data)
    //                    //return res?
    //                    self.ress = res
    //                    print(res.results.count)
    //                    print(res.results.first?.name ?? "" )
    //                    var test = self.ress?.results[0].name
    //                    print(test ?? "nress nil")
    //                } catch {
    //                    print("ERROR!!!", error)
    //                }
    //
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkRequest.request(urlString: urlString3) { [weak self] (result) in
            switch result {
                
            case .success(let allcharacters):
                self?.result = allcharacters
                self?.myTableView.reloadData()
                allcharacters.results.map({names in
                    print(names.name)
                } )
            case .failure(let error):
                print(error)
            }
        }
//        DispatchQueue.main.async {
//            self.doRequest()
//            var ress2: AllCharacters? = self.ress
//            print("status", self.ress?.results.first?.status)
//        }
//        myTableView.reloadData()
        //print("Didload: ",self.ress?.results.first?.name ?? "no name")
        

    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results.count  ?? 3 //self.ress?.results.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CharacterInfoTableViewCell
        
        cell.chatacterNameLabel.text = result?.results[indexPath.row].name
        cell.characterStatusLabel.text = result?.results[indexPath.row].status
        cell.characterLastSeenLocLabel.text = result?.results[indexPath.row].location.name
        //ress?.results.first?.name ?? "dfgdg"
        
        return cell
    }
    
    
}
