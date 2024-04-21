import UIKit

class QuestionsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var questions: [Question] = []

    static func loadController(with engineer: Engineer, and questions: [Question]) -> QuestionsViewController {
        let viewController = QuestionsViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.setUp(with: engineer, and: questions)
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

    func setUp(with engineer: Engineer, and questions: [Question]) {
        loadViewIfNeeded()
        
        addProfile(with: engineer)

        for question in questions {
            addQuestion(with: question)
        }

        self.questions = questions
    }
    
    private func addProfile(with engineer: Engineer) {
        guard let profileView = ProfileView.loadView() else { return }
        profileView.setUp(imageName: engineer.defualtImageName,
                          name: engineer.name,
                          role: engineer.role,
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
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}
