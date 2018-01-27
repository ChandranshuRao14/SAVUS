//
//  TweetCell.swift
//  SAVUS
//
//  Created by Anshu Rao on 1/27/18.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageText)
        
        messageText.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        messageText.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 4).isActive = true
        messageText.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageText.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let messageText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    var tweet: Any? {
        didSet {
            guard let t = tweet as? Tweet else { return }
            
            // Add the name in bold
            let attributedText = NSMutableAttributedString(string: t.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
            
            // Add the Twitter username in grey color (and a new line)
            attributedText.append(NSAttributedString(string: " @\(t.username)\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            
            // Modify the line spacing of the previous line so they look a litle separated
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            let range = NSMakeRange(0, attributedText.string.characters.count)
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
            
            // Add the message
            attributedText.append(NSAttributedString(string: t.message, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
            
            messageText.attributedText = attributedText
            
            // Compose the image URL with the username and set it with AlamofireImage
            let imageUrl = URL(string: "https://twitter.com/" + t.username + "/profile_image")
            profileImage.af_setImage(withURL: imageUrl!)
        }
    }

    
}
