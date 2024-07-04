
import UIKit

class CelulaLojaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagemproduto: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var valor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
