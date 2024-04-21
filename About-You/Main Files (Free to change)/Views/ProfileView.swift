import UIKit

protocol ProfileViewDelegate {
    func present(_ viewController: UIViewController)
    func didChangeProfilePicture(_ image: UIImage)
}

class ProfileView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    private var delegate: ProfileViewDelegate?

    override func awakeFromNib() {
        applyStyling()
    }
    
    func setUp(image: UIImage?, name: String, role: String, delegate: ProfileViewDelegate?) {
        if let image {
            imageView.image = image
        }
        nameLabel.text = name
        roleLabel.text = role
        self.delegate = delegate
    }
    
    private func applyStyling() {
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        
        roleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)

        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }
    
    static func loadView() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        guard let view = views?.first as? Self else {
            return nil
        }
        return view
    }
    
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        delegate?.present(imagePicker)
    }
}

extension ProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            imageView.image = image
            delegate?.didChangeProfilePicture(image)
        }
        
        dismiss(picker)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       dismiss(picker)
    }
    
    private func dismiss(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
