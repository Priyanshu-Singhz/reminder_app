import UIKit

class CustomCell: UITableViewCell {
    
    // Identifier for the cell
    static let identifier = "CustomCell"
    
    // Function to load the nib for the custom cell
    static func nib() -> UINib {
        return UINib(nibName: "CustomCell", bundle: nil)
    }

    // This method is called when the cell is awakened from a nib or storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code if needed
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    // This method is called when the cell is selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private func setupUI() {
        // Make the cell's background transparent
        contentView.backgroundColor = .clear
        
        // Add curved corners to the cell
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // Optional: Add a border for better visualization
        
    }
}
