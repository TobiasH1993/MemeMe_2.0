//
//  MemeEditorViewController.swift
//  MemeMe 1.0
//
//  Created by Haeussermann, Tobias (059) on 02.03.21.
//

import Foundation
import UIKit

class MemeEditorViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var headerTextView: UITextField!
    @IBOutlet private weak var footerTextView: UITextField!
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private weak var shareButton: UIBarButtonItem!
    @IBOutlet private weak var pickFromGalleryButton: UIBarButtonItem!
    
    private let initialHeaderText = "TOP"
    private let initialFooterText = "BOTTOM"
    
    private let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.backgroundColor: UIColor.clear,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 45)!,
        NSAttributedString.Key.strokeWidth: -4
    ]
    
    private var headerTextViewDelegate: MemeCaptionTextViewDelegate!
    private var footerTextViewDelegate: MemeCaptionTextViewDelegate!
    
    // MARK: ViewController callbacks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFit
        pickFromGalleryButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        headerTextViewDelegate = MemeCaptionTextViewDelegate(initialText: initialHeaderText)
        footerTextViewDelegate = MemeCaptionTextViewDelegate(initialText: initialFooterText)
        configureTextField(target: headerTextView, delegate: headerTextViewDelegate)
        configureTextField(target: footerTextView, delegate: footerTextViewDelegate)
        
        resetViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTextField(target: UITextField, delegate: UITextFieldDelegate) {
        target.defaultTextAttributes = memeTextAttributes
        target.textAlignment = NSTextAlignment.center
        target.delegate = delegate
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewDidDisappear(animated)
    }
    
    // MARK: ImagePickerControllerDelegate callbacks
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Button actions
    
    @IBAction func onShareButtonClicked() {
        // Collect image data
        let customizedImage = generateCustomizedImageFromScreenContent()
        let memeData = collectMemeDataFromScreen(customizedImage: customizedImage)
        
        // Show activity view controller
        let activityViewController = UIActivityViewController(activityItems: [ customizedImage ], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.saveMemeToDocumentsDirectory(memeData: memeData)
                self.saveImageToPhotoAlbums(image: memeData.customizedImage)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction private func onCancelButtonClicked() {
        resetViews()
        dismiss(animated: true)
    }
    
    @IBAction private func onPickImageFromGalleryClicked() {
        showImagePickerForSourceType(sourceType: .photoLibrary)
    }
    
    @IBAction private func onPickImageFromCameraClicked() {
        showImagePickerForSourceType(sourceType: .camera)
    }
    
    private func showImagePickerForSourceType(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Persistence
    
    private func saveMemeToDocumentsDirectory(memeData: MemeData) {
        let imageAsPNG = memeData.customizedImage.pngData()
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentDirectory.appendingPathComponent("\(memeData.topText).png")
        try? imageAsPNG?.write(to: filePath)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(memeData)
    }
    
    private func saveImageToPhotoAlbums(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    // MARK: UI interaction
    
    private func resetViews() {
        imageView.image = nil
        headerTextView.text = initialHeaderText
        footerTextView.text = initialFooterText
        shareButton.isEnabled = false
    }
    
    func collectMemeDataFromScreen(customizedImage: UIImage) -> MemeData {
        return MemeData(
            originalImage: imageView.image,
            customizedImage: customizedImage,
            topText: headerTextView.text ?? "",
            bottomText: footerTextView.text ?? ""
        )
    }
    
    func generateCustomizedImageFromScreenContent() -> UIImage {
        // Hide navbar and toolbar for capturing screen
        changeHeaderAndFooterBarVisibility(show: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let customizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show navbar and toolbar again
        changeHeaderAndFooterBarVisibility(show: true)
        
        return customizedImage
    }
    
    private func changeHeaderAndFooterBarVisibility(show: Bool) {
        self.navigationController?.navigationBar.isHidden = !show
        toolbar.isHidden = !show
    }
    
    // MARK: KeyboardInteractions
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if !self.headerTextView.isFirstResponder && view.frame.origin.y >= 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc private func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
