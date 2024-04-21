import XCTest
@testable import About_You

class EngineersViewModelTests: XCTestCase {
    // Could also be called 'sut' (system under test) depending on coding standards
    var viewModel: EngineersViewModel?
    
    override func setUp() {
        viewModel = EngineersViewModel()
    }
    
    func test_EngineersViewModel_defaultOrder() {
        // GIVEN
        guard let viewModel else {
            XCTFail("viewModel was not setup")
            return
        }
        
        // THEN
        XCTAssertEqual(viewModel.engineers.count, 6)
        
        XCTAssertEqual(viewModel.engineers[0].name, "Reenen")
        XCTAssertEqual(viewModel.engineers[1].name, "Wilmar")
        XCTAssertEqual(viewModel.engineers[2].name, "Eben")
        XCTAssertEqual(viewModel.engineers[3].name, "Stefan")
        XCTAssertEqual(viewModel.engineers[4].name, "Brandon")
        XCTAssertEqual(viewModel.engineers[5].name, "Henri")
    }
    
    func test_EngineersViewModel_orderedByYears() {
        // GIVEN
        guard let viewModel else {
            XCTFail("viewModel was not setup")
            return
        }
        
        // WHEN
        viewModel.orderEngineersBy(.Years)
        
        // THEN
        //"Wilmar"      years=15
        //"Henri"       years=10
        //"Brandon"     years=9
        //"Stefan"      years=7
        //"Reenen"      years=6
        //"Eben"        nil
        XCTAssertEqual(viewModel.engineers[0].name, "Wilmar")
        XCTAssertEqual(viewModel.engineers[1].name, "Henri")
        XCTAssertEqual(viewModel.engineers[2].name, "Brandon")
        XCTAssertEqual(viewModel.engineers[3].name, "Stefan")
        XCTAssertEqual(viewModel.engineers[4].name, "Reenen")
        XCTAssertEqual(viewModel.engineers[5].name, "Eben")
    }
    
    func test_EngineersViewModel_orderedByCoffees() {
        // GIVEN
        guard let viewModel else {
            XCTFail("viewModel was not setup")
            return
        }
        
        // WHEN
        viewModel.orderEngineersBy(.Coffees)
        
        // THEN
        // "Brandon"     coffees=99999
        // "Stefan"      coffees=9000
        // "Reenen"      coffees=5400
        // "Wilmar"      coffees=4000
        // "Henri"       coffees=1800
        // "Eben"        nil
        XCTAssertEqual(viewModel.engineers[0].name, "Brandon")
        XCTAssertEqual(viewModel.engineers[1].name, "Stefan")
        XCTAssertEqual(viewModel.engineers[2].name, "Reenen")
        XCTAssertEqual(viewModel.engineers[3].name, "Wilmar")
        XCTAssertEqual(viewModel.engineers[4].name, "Henri")
        XCTAssertEqual(viewModel.engineers[5].name, "Eben")
    }
    
    func test_EngineersViewModel_orderedByBugs() {
        // GIVEN
        guard let viewModel else {
            XCTFail("viewModel was not setup")
            return
        }
        
        // WHEN
        viewModel.orderEngineersBy(.Bugs)
        
        // THEN
        // "Brandon"     bugs=99999
        // "Wilmar"      bugs=4000
        // "Reenen"      bugs=1800
        // "Henri"       bugs=1000
        // "Stefan"      bugs=700
        // "Eben"        nil
        XCTAssertEqual(viewModel.engineers[0].name, "Brandon")
        XCTAssertEqual(viewModel.engineers[1].name, "Wilmar")
        XCTAssertEqual(viewModel.engineers[2].name, "Reenen")
        XCTAssertEqual(viewModel.engineers[3].name, "Henri")
        XCTAssertEqual(viewModel.engineers[4].name, "Stefan")
        XCTAssertEqual(viewModel.engineers[5].name, "Eben")
    }
}
