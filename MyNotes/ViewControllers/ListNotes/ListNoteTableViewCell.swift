//
//  ListNoteTableViewCell.swift
//  MyNotes
//
//  Created by zedsbook on 10/12/2022.
//

import UIKit

class ListNoteTableViewCell: UITableViewCell {

    static let identifier = "ListNoteTableViewCell"
    
    @IBOutlet weak var stackViewWithLabels: UIStackView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var descriptionLbl: UILabel!
    
    func setup(note: Note) {
        if note.title == "" {
            titleLbl.text = "Untitled"
            myImageView.image = #imageLiteral(resourceName: "hehe")
        } else {
            titleLbl.text = note.title
        }
        descriptionLbl.text = note.desc
        if let dataImage = note.image {
            myImageView.image = UIImage(data: dataImage)?.compressImage(
                maxHeight: 200,
                maxWidth: 200,
                compressionQuality: 0.01)
            ?? #imageLiteral(resourceName: "hehe").compressImage(
                maxHeight: 200,
                maxWidth: 200,
                compressionQuality: 0.01)
        } else {
            myImageView.image = #imageLiteral(resourceName: "hehe").compressImage(
                maxHeight: 200,
                maxWidth: 200,
                compressionQuality: 0.01)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setupImageView()
        setupConstraints()
    }
    
    func setupImageView() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFill
        
        myImageView.layer.cornerRadius = 15
        myImageView.backgroundColor = .white
    }
    
    func setupConstraints() {
        stackViewWithLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                myImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                myImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                myImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                myImageView.widthAnchor.constraint(equalToConstant: bounds.size.height),
                
                stackViewWithLabels.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                stackViewWithLabels.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10),
                stackViewWithLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                stackViewWithLabels.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
                
            ]
        )
    }
}

