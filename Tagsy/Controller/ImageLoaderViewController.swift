import UIKit

class ImageLoaderViewController: UIViewController {
  
  var delegate : ImageLoaderViewControllerDelegate?
  var uploadedImage : UploadedImage?

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var progressView: UIProgressView!
  
  override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    if let uploaded = uploadedImage {
      imageView.image = uploaded.image
    }
    view.sendSubviewToBack(imageView)
    uploadImage()
    // Do any additional setup after loading the view.
    }
  
  func uploadImage(){
    guard let image = uploadedImage else {return}
    ImaggaAPI.shared.postUpload(
      image: image.image,
      progressCompletion: { newProgress in
      self.progressView.progress = newProgress},
      completion: { (id,tags,colors) in
      if let id = id {
        self.uploadedImage?.id = id
      }
      if let tags = tags {
            self.uploadedImage?.tags = tags
          }
        if let colors = colors {
          self.uploadedImage?.colors = colors
            }
      if let uploaded = self.uploadedImage {
        self.delegate?.addUploadedImage(uploadedImage: uploaded)
      }
    
      self.delegate?.dismiss()
    })

  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
