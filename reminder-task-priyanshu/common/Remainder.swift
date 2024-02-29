import Foundation

struct Reminder : Codable{
    var title: String
    var dateTime: Date
}
var reminders: [Reminder] = []


class USerDataStoreOnLocal{
    static let defaults = USerDataStoreOnLocal()
    func getDataFromDefaults() -> [Reminder] {
        if let storedData = UserDefaults.standard.data(forKey: "dataArray") {
            do {
                let decoder = JSONDecoder()
                reminders = try decoder.decode([Reminder].self, from: storedData)
            } catch {
                print("Error decoding data: \(error)")
            }
        } else {
            reminders = []
        }
        return reminders
    }
func setdataInDefaults() {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(reminders)
            UserDefaults.standard.set(encodedData, forKey: "dataArray")
        } catch {
            print("Error encoding data: \(error)")
        }
    }
}
