import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    
    @IBOutlet weak var reminderTable: UITableView!
    
    
    
    @IBOutlet weak var txtField: UILabel!
    
    
    
    
    @IBOutlet weak var tablView: UIView!
    
    @IBOutlet weak var firstScreenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        reminders =  USerDataStoreOnLocal.defaults.getDataFromDefaults()
        if(reminders.isEmpty){
              tablView.isHidden = true
              firstScreenView.isHidden = false
            } else {
              tablView.isHidden = false
              firstScreenView.isHidden = true
            }
      
        txtField.layer.cornerRadius = 10
        
        txtField.layer.masksToBounds = true
        reminderTable.backgroundColor = .clear
        
        reminderTable.delegate = self
        reminderTable.dataSource = self
        reminderTable.register(CustomCell.nib(), forCellReuseIdentifier: CustomCell.identifier)
    }
    
    @IBAction func addReminderButton(_ sender: UIButton) {
        // This method doesn't seem to do anything meaningful. If it's supposed to navigate to the add screen, you need to implement it.
        performSegue(withIdentifier: "addScrn", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        
        // Retrieve the reminder for the current row from the shared reminders array
        let reminder = reminders[indexPath.row]
        
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
    //      Handle edit action
         self.handleEdit(cell: cell)
        }
        alertController.addAction(editAction)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
         // Handle delete action
         self.handleDelete(cell: cell)
            
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        // Present the alert controller
        self.present(alertController, animated: true, completion: nil)
      }

    private func handleEdit(cell : CustomCell) {
        guard let indexPath = reminderTable.indexPath(for: cell) else { return }
        let selectedReminder = reminders[indexPath.row]
        performSegue(withIdentifier: "addScrn", sender: (selectedReminder, indexPath.row))
    }
    func viewWillAppearCustom(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(reminders.isEmpty){
              tablView.isHidden = true
              firstScreenView.isHidden = false
            } else {
              tablView.isHidden = false
              firstScreenView.isHidden = true
            }

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addScrn" {
            if let addScreenVC = segue.destination as? AddScreenViewController,
               let data = sender as? (Reminder, Int) {
                addScreenVC.editingReminder = data.0
                addScreenVC.reminderIndex = data.1
                addScreenVC.delegate = self
            }
        }
    }



    private func handleDelete(cell: CustomCell) {
        guard let indexPath = reminderTable.indexPath(for: cell) else { return }
        // Perform deletion logic
        reminders.remove(at: indexPath.row)
        reminderTable.deleteRows(at: [indexPath], with: .automatic)
        viewWillAppearCustom(true)
        USerDataStoreOnLocal.defaults.setdataInDefaults()
        
        
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
