import UIKit

class GlucodianTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        profileImage.image = UIImage.init(systemName: "person.fill")
    }

    func setUp(with image: UIImage?, name: String, role: String) {
        if let image {
            profileImage.image = image
        }
        nameLabel.text = name
        roleLabel.text = role
    }
}
