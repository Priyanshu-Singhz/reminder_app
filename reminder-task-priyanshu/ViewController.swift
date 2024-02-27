//
//  ViewController.swift
//  reminder-task-priyanshu
//
//  Created by Zignuts Technolab on 27/02/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    // Dummy data
    let dummyData = ["Item 1", "Item 2", "Item 3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // Return the number of items in your dummy data array
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
//        cell.textLabel?.text = dummyData[indexPath.row] // Set the text of the cell using the dummy data
//        return cell
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for cells
        return 75// Adjust this value to your desired height
    }
    

    
    @IBOutlet weak var reminderTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        reminderTable.backgroundColor = .clear

        
        reminderTable.delegate = self
        reminderTable.dataSource = self
        reminderTable.register(CustomCell.nib(), forCellReuseIdentifier: CustomCell.identifier) // Register the custom cell
    
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
