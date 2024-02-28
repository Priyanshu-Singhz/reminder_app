
import UIKit
protocol AddScreenDelegate: AnyObject {
    func didCreateReminder(_ reminder: Reminder)
}
class AddScreenViewController: UIViewController {
    weak var delegate: AddScreenDelegate?
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    let dateTimePicker = UIDatePicker()

    var editingReminder: Reminder?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        self.navigationItem.hidesBackButton = true

        dateTimePicker.datePickerMode = .dateAndTime
        dateTimePicker.preferredDatePickerStyle = .inline
        dateTextField.inputView = dateTimePicker
        dateTimePicker.frame = CGRect(x: 10, y: 0, width: 0, height: 500)
        dateTimePicker.backgroundColor = .white
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneDateButton = UIBarButtonItem(title: "Done (Date)", style: .plain, target: self, action: #selector(doneDateButtonPressed))
        toolbar.setItems([doneDateButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
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
        guard let title = titleTextField.text, !title.isEmpty else {
            // Show an error message or handle empty title
            return
        }

        let reminder = editingReminder ?? Reminder(title: "", dateTime: Date())

        reminder.title = title
        reminder.dateTime = dateTimePicker.date

        if editingReminder == nil {
            // Add the reminder to the shared reminders array
            ReminderManager.shared.reminders.append(reminder)
        }
        
        // Notify the delegate
        delegate?.didCreateReminder(reminder)
        
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
