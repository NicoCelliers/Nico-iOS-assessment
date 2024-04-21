import XCTest
@testable import About_You

class EngineersTableViewControllerTests: XCTestCase {
    // Could also be called 'sut' (system under test) depending on coding standards
    var controller: EngineersTableViewController?
    
    override func setUp() {
        controller = EngineersTableViewController()
    }
    
    func test_EngineersTableViewController_defaultOrder() {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        
        // THEN
        XCTAssertEqual(controller.tableView.numberOfSections, 1)
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 6)
        
        XCTAssertEqual(getGlucodianTableViewCell(at: 0)?.nameLabel.text, "Reenen")
        XCTAssertEqual(getGlucodianTableViewCell(at: 1)?.nameLabel.text, "Wilmar")
        XCTAssertEqual(getGlucodianTableViewCell(at: 2)?.nameLabel.text, "Eben")
        XCTAssertEqual(getGlucodianTableViewCell(at: 3)?.nameLabel.text, "Stefan")
        XCTAssertEqual(getGlucodianTableViewCell(at: 4)?.nameLabel.text, "Brandon")
        XCTAssertEqual(getGlucodianTableViewCell(at: 5)?.nameLabel.text, "Henri")
    }
    
    func test_EngineersTableViewController_orderedByYears() {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        
        // WHEN
        controller.didSelect(orderBy: .Years)
        
        // THEN
        //"Wilmar"      years=15
        //"Henri"       years=10
        //"Brandon"     years=9
        //"Stefan"      years=7
        //"Reenen"      years=6
        //"Eben"        nil
        XCTAssertEqual(getGlucodianTableViewCell(at: 0)?.nameLabel.text, "Wilmar")
        XCTAssertEqual(getGlucodianTableViewCell(at: 1)?.nameLabel.text, "Henri")
        XCTAssertEqual(getGlucodianTableViewCell(at: 2)?.nameLabel.text, "Brandon")
        XCTAssertEqual(getGlucodianTableViewCell(at: 3)?.nameLabel.text, "Stefan")
        XCTAssertEqual(getGlucodianTableViewCell(at: 4)?.nameLabel.text, "Reenen")
        XCTAssertEqual(getGlucodianTableViewCell(at: 5)?.nameLabel.text, "Eben")
    }
    
    func test_EngineersTableViewController_orderedByCoffees() {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        
        // WHEN
        controller.didSelect(orderBy: .Coffees)
        
        // THEN
        // "Brandon"     coffees=99999
        // "Stefan"      coffees=9000
        // "Reenen"      coffees=5400
        // "Wilmar"      coffees=4000
        // "Henri"       coffees=1800
        // "Eben"        nil
        XCTAssertEqual(getGlucodianTableViewCell(at: 0)?.nameLabel.text, "Brandon")
        XCTAssertEqual(getGlucodianTableViewCell(at: 1)?.nameLabel.text, "Stefan")
        XCTAssertEqual(getGlucodianTableViewCell(at: 2)?.nameLabel.text, "Reenen")
        XCTAssertEqual(getGlucodianTableViewCell(at: 3)?.nameLabel.text, "Wilmar")
        XCTAssertEqual(getGlucodianTableViewCell(at: 4)?.nameLabel.text, "Henri")
        XCTAssertEqual(getGlucodianTableViewCell(at: 5)?.nameLabel.text, "Eben")
    }
    
    func test_EngineersTableViewController_orderedByBugs() {
        // GIVEN
        guard let controller else {
            XCTFail("controller was not setup")
            return
        }
        
        // WHEN
        controller.didSelect(orderBy: .Bugs)
        
        // THEN
        // "Brandon"     bugs=99999
        // "Wilmar"      bugs=4000
        // "Reenen"      bugs=1800
        // "Henri"       bugs=1000
        // "Stefan"      bugs=700
        // "Eben"        nil
        XCTAssertEqual(getGlucodianTableViewCell(at: 0)?.nameLabel.text, "Brandon")
        XCTAssertEqual(getGlucodianTableViewCell(at: 1)?.nameLabel.text, "Wilmar")
        XCTAssertEqual(getGlucodianTableViewCell(at: 2)?.nameLabel.text, "Reenen")
        XCTAssertEqual(getGlucodianTableViewCell(at: 3)?.nameLabel.text, "Henri")
        XCTAssertEqual(getGlucodianTableViewCell(at: 4)?.nameLabel.text, "Stefan")
        XCTAssertEqual(getGlucodianTableViewCell(at: 5)?.nameLabel.text, "Eben")
    }
    
    private func getGlucodianTableViewCell(at row: Int) -> GlucodianTableViewCell? {
        guard let controller else { return nil }
        
        return controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: row, section: 0)) as? GlucodianTableViewCell
    }
}
