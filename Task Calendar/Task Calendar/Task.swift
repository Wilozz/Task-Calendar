import Foundation

struct Task: Codable, Identifiable {
    let id: UUID
    var name: String
    var loggedDates: Set<Date>

    init(id: UUID = UUID(), name: String, loggedDates: Set<Date> = []) {
        self.id = id
        self.name = name
        self.loggedDates = loggedDates
    }
}
