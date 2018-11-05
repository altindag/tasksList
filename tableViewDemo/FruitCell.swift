import UIKit

class FruitCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var cellTextInput: UITextView!
    var task: String? {
        didSet {
            if let fruit = task {
                icon.image = UIImage(named: fruit)
                icon.contentMode = .scaleAspectFit
                //cellTextInput.text = task;
            }
        }
    }
    
}
