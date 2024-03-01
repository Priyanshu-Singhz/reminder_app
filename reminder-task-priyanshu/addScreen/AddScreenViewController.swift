import UIKit
import UserNotifications
protocol AddScreenDelegate: AnyObject {
    func didCreateReminder(_ reminder: Reminder)
}
class AddScreenViewController: UIViewController {
    weak var delegate: AddScreenDelegate?
    
    var reminderIndex: Int?
    
    

    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    let dateTimePicker = UIDatePicker()
    
    var editingReminder: Reminder?
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
       
        self.navigationItem.hidesBackButton = true
       
           
        
        
        dateTimePicker.datePickerMode = .dateAndTime
        dateTimePicker.preferredDatePickerStyle = .inline
        dateTextField.inputView = dateTimePicker
        dateTimePicker.frame = CGRect(x: 10, y: 0, width: 0, height: 480)
        dateTimePicker.backgroundColor = .white
        dateTimePicker.tintColor = UIColor(cgColor: CGColor(red: CGFloat(108)/255, green: CGFloat(194)/255, blue: CGFloat(181)/255, alpha: 1))
      
        dateTimePicker.minimumDate = NSDate() as Date
        
        
        let doneDateButton = UIBarButtonItem(title: "Done (Date)", style: .plain, target: self, action: #selector(doneDateButtonPressed))
        
        
        if let reminder = editingReminder {
            // Fill the text fields with reminder data
            titleTextField.text = reminder.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            dateTextField.text = dateFormatter.string(from: reminder.dateTime)
        }
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        dateTextField.inputAccessoryView = toolbar
        toolbar.setItems([doneDateButton], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let reminder = editingReminder {
            titleTextField.text = reminder.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            dateTextField.text = dateFormatter.string(from: reminder.dateTime)
        }
    }
    
    @objc func doneDateButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateTextField.text = dateFormatter.string(from: dateTimePicker.date)
        dateTextField.textColor = .blue
        dateTextField.resignFirstResponder()
    }
    
    
    
    @IBAction func createReminderButton(_ sender: UIButton) {
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            // Show an error message or handle empty title
            return
        }
        
        // Create a new Reminder instance or update the existing one
        var reminder = editingReminder ?? Reminder(title: "", dateTime: Date())
        reminder.title = title
        reminder.dateTime = dateTimePicker.date
        
        // Update the reminders array at the specified index
        if let index = reminderIndex {
            reminders[index] = reminder
        } else {
            // If no index is provided, append the new reminder
            reminders.append(reminder)
        }
        
        //yeh bas mene notifications ke liye banaya h
        // Save the updated reminders array to UserDefaults
        USerDataStoreOnLocal.defaults.setdataInDefaults()
        let content = UNMutableNotificationContent()
            content.title = "Reminder: \(title)"
        content.body = titleTextField.text!
            content.sound = UNNotificationSound.default
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.dateTime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: "reminder_\(UUID().uuidString)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Failed to schedule notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        //yaha tak notifications ka part
        
        // Notify the delegate
        delegate?.didCreateReminder(reminder)
        
        // Perform segue
        performSegue(withIdentifier: "reverse", sender: nil)
    }

    
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func initializeView() {
        navigationItem.hidesBackButton = true
        titleTextField.borderStyle = .none
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.borderColor = UIColor.white.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: titleTextField.frame.size.height))
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Where to ?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
        
        dateTextField.leftView = paddingView
        dateTextField.leftViewMode = .always
        dateTextField.borderStyle = .none
        dateTextField.layer.cornerRadius = 20
        dateTextField.layer.borderWidth = 2
        dateTextField.layer.borderColor = UIColor.white.cgColor
        let paddingViewfordate = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: titleTextField.frame.size.height))
        dateTextField.attributedPlaceholder = NSAttributedString(string: "What Date and Time ?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        dateTextField.leftView = paddingViewfordate
        dateTextField.leftViewMode = .always
    }
}
