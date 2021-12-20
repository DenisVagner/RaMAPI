import UIKit

class CharacterInfoViewController: UIViewController {
    var idInfo = 0
    let networkRequest = NetworkRequestAF()
    var resultOne: CharacterInfo? = nil
    var urlString: String {
        get {
            return "https://rickandmortyapi.com/api/character/\(idInfo)"
        }
    }
    
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoLiveStatusLabel: UILabel!
    @IBOutlet weak var infoSpeciesLabel: UILabel!
    @IBOutlet weak var infoLastLocLabel: UILabel!
    @IBOutlet weak var infoFirstSeenLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromNetworkAFOne()
    }
    
    // запрос данных одного нажатого персонаже
    func loadFromNetworkAFOne() {
        activityIndicator.isHidden = false
        networkRequest.requestOne(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let onecharacter):
                self?.resultOne = onecharacter
                self?.setLabels()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // заполнение полей о персонаже
    func setLabels() {
        infoNameLabel.text = resultOne?.name
        infoLiveStatusLabel.text = resultOne?.status
        infoSpeciesLabel.text = resultOne?.species
        infoLastLocLabel.text = resultOne?.location.name
        
        if let urlString = self.resultOne?.image {
            let urlImage = URL(string: urlString)
            guard let imageData = try? Data(contentsOf: urlImage!) else { return }
            let image = UIImage(data: imageData)
            
            infoImageView.image = image
            activityIndicator.isHidden = true
        }
    }
}
