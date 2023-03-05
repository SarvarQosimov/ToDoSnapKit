import Foundation

protocol finishedDelegate {
    func turnOn(section: Int, index: Int, sort: Bool)
    func turnOff(section: Int, index: Int, sort: Bool)

}

protocol RemindDelegate {
    func turnOn2(section: Int, index: Int, sort: Bool)
    func turnOff2(section: Int, index: Int, sort: Bool)

}

