//
//  EditNoteViewController.swift
//  MyNotes
//
//  Created by zedsbook on 10/12/2022.
//

import UIKit

class EditNoteViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak private var textView: UITextView!
    
    static let identifier = "EditNoteViewController"
    var note: Note!
    weak var delegate: ListNotesDelegate?
    private var tapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTapGesture()
        setupImageView()
        setupTextView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupNavigationBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc
    func save() {
        note.text = textView.text
        note.image = imageView.image?.jpegData(compressionQuality: 1)
        if !note.title.isEmpty && imageView.image?.jpegData(compressionQuality: 1) == nil {
            deleteNote()
        } else {
            updateNote()
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    private func updateNote() {
        CoreDataManager.shared.save()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        delegate?.deleteNote(with: note.id)
        CoreDataManager.shared.deleteNote(note)
    }
}

//MARK: - Setup ImageView, TextView, TapGesture
extension EditNoteViewController {
    
    func setupTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditNoteViewController.tapHappen(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
    }
    
    @objc func tapHappen(_ sender: UITapGestureRecognizer) {
        openImageGallary()
    }
    
    func openImageGallary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func setupImageView() {
        imageView.image = #imageLiteral(resourceName: "hehe")
        if let dataImage = note.image {
            imageView.image = UIImage(data: dataImage) ?? #imageLiteral(resourceName: "hehe")
        } else {
            imageView.image = #imageLiteral(resourceName: "hehe")
        }
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = .white
        
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    func setupTextView() {
        textView.text = note?.text
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        textView.layer.cornerRadius = 50
        textView.backgroundColor = .white
        textView.centerVerticalText()
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                imageView.heightAnchor.constraint(equalToConstant: view.bounds.size.width - 160),
                
                textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ]
        )
    }
}


//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension EditNoteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

