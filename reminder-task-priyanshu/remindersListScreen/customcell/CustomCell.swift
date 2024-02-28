import UIKit

protocol CustomCellDelegate: AnyObject {
    func didPressOptionButton(in cell: CustomCell)
}

class CustomCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var imageBtn: UIImageView!
    
    func configure(with reminder: Reminder) {
        titleLabel.text = reminder.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateTimeLabel.text = dateFormatter.string(from: reminder.dateTime)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
        // Add tap gesture recognizer to the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageBtn.addGestureRecognizer(tapGesture)
        imageBtn.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
        delegate?.didPressOptionButton(in: self)
    }
    
    private func setupUI() {
        // Make the cell's background transparent
        contentView.backgroundColor = .clear
        
        // Add curved corners to the cell
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // Optional: Add a border for better visualization
        
    }
    
    // Identifier for the cell
    static let identifier = "CustomCell"
    
    // Function to load the nib for the custom cell
    static func nib() -> UINib {
        return UINib(nibName: "CustomCell", bundle: nil)
    }
    
    // This method is called when the cell is selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
