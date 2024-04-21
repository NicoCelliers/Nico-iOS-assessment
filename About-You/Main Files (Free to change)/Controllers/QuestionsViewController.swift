import UIKit

protocol QuestionsViewControllerDelegate: AnyObject {
    func didChangeProfilePicture(for engineer: Engineer, image: UIImage)
}

class QuestionsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var engineer: Engineer?
    var questions: [Question] = []
    private weak var delegate: QuestionsViewControllerDelegate?

    static func loadController(with engineer: Engineer, 
                               and questions: [Question],
                               delegate: QuestionsViewControllerDelegate?) -> QuestionsViewController {
        let viewController = QuestionsViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.setUp(with: engineer, and: questions, delegate: delegate)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "About"
        scrollView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    func setUp(with engineer: Engineer, and questions: [Question], delegate: QuestionsViewControllerDelegate?) {
        loadViewIfNeeded()
        
        addProfile(with: engineer)

        for question in questions {
            addQuestion(with: question)
        }

        self.engineer = engineer
        self.questions = questions
        self.delegate = delegate
    }
    
    private func addProfile(with engineer: Engineer) {
        guard let profileView = ProfileView.loadView() else { return }
        profileView.setUp(image: engineer.image,
                          name: engineer.name,
                          role: engineer.role,
                          stats: engineer.quickStats,
                          delegate: self)
        containerStack.addArrangedSubview(profileView)
    }

    private func addQuestion(with data: Question) {
        guard let cardView = QuestionCardView.loadView() else { return }
        cardView.setUp(with: data.questionText,
                       options: data.answerOptions,
                       selectedIndex: data.answer?.index)
        containerStack.addArrangedSubview(cardView)
    }
}

extension QuestionsViewController: ProfileViewDelegate {
    func didChangeProfilePicture(_ image: UIImage) {
        guard let engineer else { return }
        engineer.pickedImage = image
        delegate?.didChangeProfilePicture(for: engineer, image: image)
    }
    
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}
