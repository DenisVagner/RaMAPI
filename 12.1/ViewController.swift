import UIKit
import Alamofire

// анимированно убрать выделение нажатой ячейки

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
        
    var result: AllCharacters? = nil
    //var nextPageData: AllCharacters? = nil
    var currentPage = 1
    var urlString: String {
        get {
            "https://rickandmortyapi.com/api/character/?page=\(currentPage)"
        }
    }
    let networkRequestAF = NetworkRequestAF()
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .utility).async {
            self.loadFromNetworkAF(url: self.urlString)
        }
        
    }
    
    // Передача ID нажатого персонажа на следующий экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = myTableView.indexPath(for: cell) {
            if let vc = segue.destination as? CharacterInfoViewController, segue.identifier == "ShowInfo" {
                vc.idInfo = (result?.results[index.row].id ?? 0)
            }
        }
    }
    
    // Запрос данных о первых 20 персонажей
    func loadFromNetworkAF(url: String) {
        networkRequestAF.requestAll(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let allcharacters):
                if self?.result == nil {
                    self?.result = allcharacters
                } else {
                    self?.result?.results += allcharacters.results
                }
                
                self?.myTableView.reloadData()
            case .failure(let error):
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", error)
                //self?.alertPresent()
            }
        }
    }
    
//    func alertPresent() {
//        let ac = UIAlertController(title: "Error", message: "No inernet", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        ac.addAction(cancelAction)
//        present(ac, animated: true, completion: nil)
//    }
    
//    func loadFromNetworkNextPage(url: String) {
//        networkRequestAF.requestAll(urlString: urlString) { [weak self] result in
//            switch result {
//
//            case .success(let allcharacters):
//                self?.nextPageData = allcharacters
//                self?.myTableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

// экстеншены для работы с таблицей
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // передеча значения количества ячеек в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results.count  ?? 3
    }
    
    // заполнение ячеек данными, полученными ранее в результате запроса
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CharacterInfoTableViewCell
        cell.chatacterNameLabel.text = result?.results[indexPath.row].name
        cell.characterStatusLabel.text = result?.results[indexPath.row].status
        cell.characterLastSeenLocLabel.text = result?.results[indexPath.row].location.name
        
        // вывод катринки персонажа
        if let urlString8 = self.result?.results[indexPath.row].image {
            cell.activityIndicatorInCell.startAnimating()
            // проверка на наличие изображения в кэше, если есть - грузить с него, если нет, то загружать картинку, выводить и затем помещать в кэш
            if let image = self.imageCache.object(forKey: urlString8 as AnyObject) as? UIImage {
                cell.characterImage.image = image
                print("Image \(indexPath.row + 1) loaded from cache")
                cell.activityIndicatorInCell.stopAnimating()
            } else {
                let urlImage = URL(string: urlString8)
                let queue = DispatchQueue.global(qos: .utility)
                queue.async {
                    if let imageData = try? Data(contentsOf: urlImage!) {
                        DispatchQueue.main.async {
                            
                            let image = UIImage(data: imageData)
                            cell.characterImage.image = image
                            self.imageCache.setObject(image!, forKey: urlString8 as AnyObject)
                            print("Image \(indexPath.row + 1) downloaded")
                            cell.activityIndicatorInCell.stopAnimating()
                            //print("next page: ", self.result?.info.next)
                        }
                    }
                    
                }
            }
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row < (result?.results.count)! {
//            loadFromNetworkNextPage(url: (result?.info.next)!)
//            self.result?.results.append(contentsOf: nextPageData!.results)
//        }
//    }
    
    // убирает выделение ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
