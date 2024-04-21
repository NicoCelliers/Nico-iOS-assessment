import XCTest
@testable import About_You

class About_YouTests: XCTestCase {

    // Steve did not really know about tests...
    // Maybe you can show him by testing the results calculations?
    
    // Could also be called 'sut' (system under test) depending on coding standards
    var controller: OrderByTableViewController?
    var orderBy: OrderBy?
    var expectation: XCTestExpectation?
    
    override func setUp() {
        controller = OrderByTableViewController()
    }
    
    func test_OrderByTableViewController_order() {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        
        // WHEN
        let firstCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let secondCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        let thirdCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        
        // THEN
        XCTAssertEqual(controller.tableView.numberOfSections, 1)
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 3)
        XCTAssertEqual(firstCell.textLabel?.text, OrderBy.Years.rawValue)
        XCTAssertEqual(secondCell.textLabel?.text, OrderBy.Coffees.rawValue)
        XCTAssertEqual(thirdCell.textLabel?.text, OrderBy.Bugs.rawValue)
    }
    
    func test_OrderByTableViewController_delegate() throws {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        controller.delegate = self
        
        // WHEN
        expectation = expectation(description: "Should select first order by option")
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // THEN
        waitForExpectations(timeout: 1)
    }
    
    func test_OrderByTableViewController_selectFirstOption() throws {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        controller.delegate = self
        
        // WHEN
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // THEN
        let selectedOption = try XCTUnwrap(orderBy)
        XCTAssertEqual(selectedOption, .Years)
    }
    
    func test_OrderByTableViewController_selectSecondOption() throws {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        controller.delegate = self
        
        // WHEN
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        
        // THEN
        let selectedOption = try XCTUnwrap(orderBy)
        XCTAssertEqual(selectedOption, .Coffees)
    }
    
    func test_OrderByTableViewController_selectThirdOption() throws {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        controller.delegate = self
        
        // WHEN
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 2, section: 0))
        
        // THEN
        let selectedOption = try XCTUnwrap(orderBy)
        XCTAssertEqual(selectedOption, .Bugs)
    }
    
    func test_OrderByTableViewController_selectOption_shouldSetCheckmark() throws {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        controller.delegate = self
        
        // WHEN
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // THEN
        let selectedCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(selectedCell.accessoryType, .checkmark)
    }
    
    func test_OrderByTableViewController_selectingAnotherOption_shouldRemoveCheckmark() {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        controller.delegate = self
        
        // WHEN
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // THEN
        var firstSelectedCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstSelectedCell.accessoryType, .checkmark)
        
        // WHEN
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        firstSelectedCell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // THEN
        XCTAssertEqual(firstSelectedCell.accessoryType, .none)
    }
}

extension About_YouTests: OrderByTableViewControllerDelegate {
    func didSelect(orderBy: OrderBy) {
        self.orderBy = orderBy
        expectation?.fulfill()
        expectation = nil
    }
}
