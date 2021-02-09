import UIKit


class ImaggaAPI {
  // ImaggaAPI.shared.method()
  static public let shared = ImaggaAPI()
  
  func postUpload(
    image: UIImage,
    progressCompletion: @escaping (_ percent: Float) -> Void,
    completion: @escaping (_ id: String?) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
    AF.upload(MultipartFormData)
    
    }

  }
  
 
