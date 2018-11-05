import UIKit
protocol UpdateDelegate {
    func updateArray(item: String)
}
class DisplayEditViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var operation: String?
  
   
    @IBOutlet weak var deleteTaskButton: UIButton!
    @IBOutlet weak var markCompletedButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cellTextInput: UITextView!
    var task: String?
    var selectedIndex: Int?
    var uid : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.operation == "new"){
            self.deleteTaskButton.isHidden = true
            self.markCompletedButton.isHidden = true
        }
        cellTextInput.text = task
    }
  
       
    @IBAction func markAsCompleted(_ sender: Any) {
        
        self.operation = "markCompleted"
        performSegue(withIdentifier: "backTransition", sender: self)
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        self.operation = "deleteTask"
         performSegue(withIdentifier: "backTransition", sender: self)
    }
    @IBAction func saveAndBack(_ sender: Any) {
         
         performSegue(withIdentifier: "backTransition", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListTasksViewController {
            
            destination.returnValue = cellTextInput.text
            destination.operation = self.operation
            if let selIndex = selectedIndex{
                destination.selectedIndex = selIndex
                destination.uid = self.uid
            }
        }
    }
    
}
