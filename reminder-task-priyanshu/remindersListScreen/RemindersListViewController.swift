//
//  RemindersListViewController.swift
//  reminder-task-priyanshu
//
//  Created by Zignuts Technolab on 27/02/24.
//

import UIKit

class RemindersListViewController: UIViewController {
   
    
    @IBAction func CreateNewRemainder(_ sender: UIButton) {
        performSegue(withIdentifier: "navtoadd", sender: nil)
    }
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.cornerRadius = 10
        
        

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
