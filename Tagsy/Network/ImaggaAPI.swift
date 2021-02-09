import UIKit
import Alamofire
import SwiftyJSON


class ImaggaAPI {
  // ImaggaAPI.shared.method()
  static public let shared = ImaggaAPI()
  
  func postUpload(
    image: UIImage,
    progressCompletion: @escaping (_ percent: Float) -> Void,
    completion: @escaping (_ id: String?) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
    AF.upload(multipartFormData: { multipartFormData in
      multipartFormData.append(imageData, withName: "image")
    }, with: ImaggaRouter.upload)
    .uploadProgress(queue: .main, closure: { progress in
      //Current upload progress of file
      //This will update a progress bar in our ImageLoaderViewController
      progressCompletion(Float(progress.fractionCompleted))
    })
    .responseJSON { response in
      switch response.result {
      // our request was successful (200)
      case .success(let json):
        // grab the upload id from the result using SwiftyJSON
        let uploadedImageID = JSON(json)["result"]["upload_id"].stringValue
        print("Image uploaded with ID: \(uploadedImageID)")
        completion(uploadedImageID)
      // error (400)
      case .failure(let error):
        print("Error while uploading file: \(String(describing: error))")
        completion(nil)
        
      }
    }
  }
}

