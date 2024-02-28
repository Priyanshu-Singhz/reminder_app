import Foundation

class Reminder {
    var title: String
    var dateTime: Date

    init(title: String, dateTime: Date) {
        self.title = title
        self.dateTime = dateTime
    }
}
