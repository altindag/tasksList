import UIKit

var tempArray: [[String]] = [["task 1", "1","1"],["task 2", "0","2"]]
var taskArray = [[String]]()
var cpArray = [[String]]()
var id : Int = 4
class ListTasksViewController: UITableViewController {
    
    var listcondition : String = "all"
    var selected: String?
    var selectedIndex: Int = -1
    var returnValue : String?
    var operation : String?
    var uid : Int = -1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskArray.count
    }
    
    @IBAction func switchAllList(_ sender: Any) {
        self.listcondition = "all"
        //taskArray.removeAll();
        taskArray.removeAll()
        taskArray = tempArray.map { $0 }
        //taskArray = tempArray

        
        print(taskArray)
        tableView.reloadData()
 
    }
    @IBAction func switchCompletedList(_ sender: Any) {
        self.listcondition = "completed"
        taskArray.removeAll()
        //var eachTuple = [String]()
        let arrSize = tempArray.count
        var eachtuple = [String]()
     
        for row in 0..<arrSize{
 
                if (tempArray[row][1] == "1"){

taskArray.append([tempArray[row][0],tempArray[row][1],tempArray[row][2]])
            }
        }

        print(taskArray)
        tableView.reloadData()

    }
    
    @IBAction func switchUncompletedList(_ sender: Any) {
        self.listcondition = "uncompleted"
        taskArray.removeAll()
        //taskArray = tempArray.map { $0 }
        //taskArray.removeAll()
        //var eachTuple = [String]()
        let arrSize = tempArray.count
        var eachtuple = [String]()
        
        for row in 0..<arrSize{
            
            if (tempArray[row][1] == "0"){
                //eachtuple.append(tempArray[row][0])
                //eachtuple.append(tempArray[row][1])
                taskArray.append([tempArray[row][0],tempArray[row][1],tempArray[row][2]])
                
            }
        }
        
        print(taskArray)
        tableView.reloadData()
    }
    @IBAction func addNewTask(_ sender: Any) {
        self.operation = "new"
        performSegue(withIdentifier: "fruitTransition", sender: self)
        print(taskArray.count)
        
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var taskText: String = ""
        var cell : FruitCell
        taskText = taskArray[indexPath.row][0]
        cell = tableView.dequeueReusableCell(withIdentifier: "fruitsCell") as! FruitCell
        cell.cellTextInput?.text = taskText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.operation = "edit"
        selected = taskArray[indexPath.row][0]
        selectedIndex = indexPath.row
        self.uid = Int(taskArray[indexPath.row][2])!
        print("index at click"+String(selectedIndex))
        performSegue(withIdentifier: "fruitTransition", sender: self)
        //selected = returnValue
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? DisplayEditViewController {
            if (self.operation == "edit"){
                destination.operation = self.operation
                destination.task = selected
                destination.selectedIndex = selectedIndex
                destination.uid = uid
            }else if (self.operation == "new"){
                destination.operation = self.operation
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        self.navigationItem.setHidesBackButton(true, animated:true);

    }
    override func viewDidLoad() {
        print("view did load")
        taskArray.removeAll()
       
       
        if let myArra = (UserDefaults.standard.object(forKey: "tempArray")as? [[String]]){
            tempArray = myArra.map{$0}
             taskArray = myArra.map{$0}
            //tableView.reloadData()
        }else{
            taskArray = tempArray.map { $0 }
            
        }
        if let myId = (UserDefaults.standard.integer(forKey: "id") as? Int ){
            id = myId
           
            //tableView.reloadData()
        }
        
        
        
        if (self.operation == "new"){
            if let retValue = returnValue{
                print("saving")
                //var row = [String]()
                //row.append(retValue)
                //row.append("0")
                id = id + 1
                tempArray.append([retValue, "0", String(id) ])
               // print("row : "+row)
                //taskArray = tempArray
                taskArray.removeAll()
                taskArray = tempArray.map { $0 }
                UserDefaults.standard.set(tempArray, forKey: "tempArray")
                
                UserDefaults.standard.set(id, forKey: "id")
                tableView.reloadData()
            }
        }else if (self.operation == "edit"){
            if let retValue = returnValue{
                for row in 0..<tempArray.count{
                    if (tempArray[row][2] == String(self.uid)){
                        tempArray[row][0] = retValue
                        break
                    }
                }
                //taskArray[selectedIndex][0] = retValue
                taskArray.removeAll()
                taskArray = tempArray.map { $0 }
                UserDefaults.standard.set(tempArray, forKey: "tempArray")
                tableView.reloadData()
            }
        }else if (self.operation == "deleteTask"){
            
            var delIndex : Int = -1
            if let retValue = returnValue{
                for row in 0..<tempArray.count{
                    if (tempArray[row][2] == String(self.uid)){
                        delIndex = row
                        break
                    }
                }
                tempArray.remove(at: delIndex)
                //taskArray[selectedIndex][0] = retValue
                taskArray.removeAll()
                taskArray = tempArray.map { $0 }
                UserDefaults.standard.set(tempArray, forKey: "tempArray")
                tableView.reloadData()
            }
            
        }else if (self.operation == "markCompleted"){
            
           
            
                for row in 0..<tempArray.count{
                    if (tempArray[row][2] == String(self.uid)){
                        
                        tempArray[row][1] = "1"
                        break
                    }
                
                
                //taskArray[selectedIndex][0] = retValue
               
            }
            taskArray.removeAll()
            taskArray = tempArray.map { $0 }
            UserDefaults.standard.set(tempArray, forKey: "tempArray")
            tableView.reloadData()
        }
        print(self.operation)
        print(selectedIndex)
    
    }

    

}
