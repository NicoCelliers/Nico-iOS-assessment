import UIKit

class EngineersTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var viewModel: EngineersViewModel = EngineersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Engineers at Glucode"
        tableView.backgroundColor = .white
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Order by",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(orderByTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func orderByTapped() {
        guard let from = navigationItem.rightBarButtonItem else { return }
        let controller = OrderByTableViewController(style: .plain)
        controller.delegate = self
        let size = CGSize(width: 200,
                          height: 150)

        present(popover: controller,
             from: from,
             size: size,
             arrowDirection: .up)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
        }

    private func registerCells() {
        tableView.register(UINib(nibName: String(describing: GlucodianTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GlucodianTableViewCell.self))
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.engineers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GlucodianTableViewCell.self)) as? GlucodianTableViewCell
        let engineer = viewModel.engineers[indexPath.row]
        cell?.setUp(with: engineer.image,
                    name: engineer.name,
                    role: engineer.role)
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEngineer = viewModel.engineers[indexPath.row]
        let controller = QuestionsViewController.loadController(with: selectedEngineer,
                                                                and: selectedEngineer.questions,
                                                                delegate: self)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension EngineersTableViewController: QuestionsViewControllerDelegate {
    func didChangeProfilePicture(for engineer: Engineer, image: UIImage) {
        viewModel.changeProfilePicture(for: engineer, with: image)
        tableView.reloadData()
    }
}

extension EngineersTableViewController: OrderByTableViewControllerDelegate {
    func didSelect(orderBy: OrderBy) {
        viewModel.orderEngineersBy(orderBy)
        tableView.reloadData()
    }
}
