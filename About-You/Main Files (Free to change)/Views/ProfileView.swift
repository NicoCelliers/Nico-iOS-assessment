import UIKit

protocol ProfileViewDelegate {
    func present(_ viewController: UIViewController)
    func didChangeProfilePicture(_ image: UIImage)
}

class ProfileView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    private var delegate: ProfileViewDelegate?

    override func awakeFromNib() {
        applyStyling()
    }
    
    func setUp(image: UIImage?, name: String, role: String, stats: QuickStats?, delegate: ProfileViewDelegate?) {
        if let image {
            imageView.image = image
        }
        
        stackView.isHidden = true
        if let stats {
            addQuickStatsView(with: stats)
            stackView.isHidden = false
        }
        updateImageViewConstraints()
        
        nameLabel.text = name
        roleLabel.text = role
        self.delegate = delegate
    }
    
    func addQuickStatsView(with stats: QuickStats) {
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let yearsView = createQuickStatView(with: "Years", value: "\(stats.years)")
        let coffeesView = createQuickStatView(with: "Coffees", value: "\(stats.coffees)")
        let bugsView = createQuickStatView(with: "Bugs", value: "\(stats.bugs)")
        
        stackView.addArrangedSubview(yearsView)
        stackView.addArrangedSubview(coffeesView)
        stackView.addArrangedSubview(bugsView)
    }
    
    func createQuickStatView(with title: String, value: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let statTitleLabel = UILabel()
        statTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        statTitleLabel.text = title
        
        let statValueLabel = UILabel()
        statValueLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        statValueLabel.text = value
        
        stackView.addArrangedSubview(statTitleLabel)
        stackView.addArrangedSubview(statValueLabel)
        
        return stackView
    }
    
    private func applyStyling() {
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        
        roleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        
        stackView.backgroundColor = .systemGray5
        stackView.layer.cornerRadius = 10
        stackView.layer.cornerCurve = .continuous

        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }
    
    private func updateImageViewConstraints() {
        if stackView.isHidden {
            imageViewHeightConstraint?.constant = 64
        } else {
            imageViewHeightConstraint?.constant = 115
        }
        layoutIfNeeded()
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
