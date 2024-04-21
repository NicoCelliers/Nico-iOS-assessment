import UIKit

final class EngineersViewModel {
    private var engineersData: [Engineer] = Engineer.testingData()
    var engineers: [Engineer] {
        engineersData
    }
    
    func changeProfilePicture(for engineer: Engineer, with image: UIImage) {
        let engineer = engineersData.first(where: { $0 == engineer })
        engineer?.pickedImage = image
    }
    
    func orderEngineersBy(_ orderBy: OrderBy) {
        switch orderBy {
        case .Years:
            engineersData.sort(by: { $0.quickStats?.years ?? 0 > $1.quickStats?.years ?? 0 })
        case .Coffees:
            engineersData.sort(by: { $0.quickStats?.coffees ?? 0 > $1.quickStats?.coffees ?? 0 })
        case .Bugs:
            engineersData.sort(by: { $0.quickStats?.bugs ?? 0 > $1.quickStats?.bugs ?? 0 })
        }
    }
}
