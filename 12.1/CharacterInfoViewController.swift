import UIKit
import Alamofire

class CharacterInfoViewController: UIViewController {
    var idInfo = 0
    let networkRequest = NetworkRequestAF()
    var resultOne: CharacterInfo? = nil
    
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoLiveStatusLabel: UILabel!
    @IBOutlet weak var infoSpeciesLabel: UILabel!
    @IBOutlet weak var infoLastLocLabel: UILabel!
    @IBOutlet weak var infoFirstSeenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromNetworkAFOne()
    }
    
    func loadFromNetworkAFOne() {
        networkRequest.requestOne(urlString: "https://rickandmortyapi.com/api/character/\(idInfo)") { [weak self] (result) in
            switch result {
            case .success(let onecharacter):
                self?.resultOne = onecharacter
                self?.setLabels()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setLabels() {
        infoNameLabel.text = resultOne?.name
        infoLiveStatusLabel.text = resultOne?.status
        infoSpeciesLabel.text = resultOne?.species
        infoLastLocLabel.text = resultOne?.location.name
        
        if let urlString8 = self.resultOne?.image {
            let urlImage = URL(string: urlString8)
            let imageData = try? Data(contentsOf: urlImage!)
            let image = UIImage(data: imageData!)
            infoImageView.image = image
        }
    }
}
