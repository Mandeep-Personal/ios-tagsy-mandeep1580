extension ImageCollectionViewController: ImageLoaderViewControllerDelegate {
  
  
  func dismiss() {
    guard let imageLoaderVC = imageLoaderViewController else {return}
    imageLoaderVC.dismiss(animated: true, completion: nil)
  }
  
  func addUploadedImage(uploadedImage: UploadedImage) {
    let index = uploadedImages.firstIndex {uploaded -> Bool in uploaded.image == uploadedImage.image}
    
    
    if let i = index {
      uploadedImages[i] = uploadedImage
    }
    
  }
}
