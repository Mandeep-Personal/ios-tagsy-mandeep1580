import UIKit

extension ImageCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
      let uploaded = UploadedImage(id: nil, image: image, tags: [], colors: [])
      uploadedImages.append(uploaded)
      imagePicker.dismiss(animated: false, completion: nil)
      
      performSegue(withIdentifier: "showImageLoader", sender: self)
      collectionView.reloadData()
    }
  }
  
}

