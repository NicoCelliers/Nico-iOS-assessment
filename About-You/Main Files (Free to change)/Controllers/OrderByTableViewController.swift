import UIKit

enum OrderBy: String, CaseIterable {
    case Years
    case Coffees
    case Bugs
}

protocol OrderByTableViewControllerDelegate: AnyObject {
    func didSelect(orderBy: OrderBy)
}

class OrderByTableViewController: UITableViewController {
    private var currentSelection: OrderBy?
    private var orderOptions: [OrderBy] = OrderBy.allCases
    weak var delegate: OrderByTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = orderOptions[indexPath.row].rawValue
        cell?.accessoryType = currentSelection == orderOptions[indexPath.row] ? .checkmark : .none
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSelection = orderOptions[indexPath.row]
        if let currentSelection,
            let currentSelectionIndex = orderOptions.firstIndex(of: currentSelection),
            let cell = tableView.cellForRow(at: IndexPath(row: currentSelectionIndex, section: 0)) {
            cell.accessoryType = .none
        }
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        currentSelection = newSelection
        delegate?.didSelect(orderBy: newSelection)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
