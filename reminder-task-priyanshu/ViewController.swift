import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    
    @IBOutlet weak var reminderTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        reminderTable.backgroundColor = .clear
        
        reminderTable.delegate = self
        reminderTable.dataSource = self
        reminderTable.register(CustomCell.nib(), forCellReuseIdentifier: CustomCell.identifier)
    }
    
    @IBAction func addReminderButton(_ sender: UIButton) {
        // This method doesn't seem to do anything meaningful. If it's supposed to navigate to the add screen, you need to implement it.
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderManager.shared.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        
        // Retrieve the reminder for the current row from the shared reminders array
        let reminder = ReminderManager.shared.reminders[indexPath.row]
        
        // Configure the cell with the reminder
        cell.configure(with: reminder)
        
        // Set the delegate for each cell
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75 // Adjust this value to your desired height
    }
    
    func didPressOptionButton(in cell: CustomCell) {
        let alertController = UIAlertController(title: "Options", message: "Choose an action", preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            // Handle edit action
            print("Edit action tapped")
        }
        alertController.addAction(editAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            // Handle delete action
            print("Delete action tapped")
        }
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert controller from the view controller
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: AddScreenDelegate {
    func didCreateReminder(_ reminder: Reminder) {
        // The reminders are managed by the ReminderManager, so no need to append here
        // Reload the table view to reflect the changes
        DispatchQueue.main.async {
            self.reminderTable.reloadData()
        }
    }
}
