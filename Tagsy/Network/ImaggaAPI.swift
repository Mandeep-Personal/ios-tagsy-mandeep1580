import UIKit
import Alamofire
import SwiftyJSON


class ImaggaAPI {
  // ImaggaAPI.shared.method()
  static public let shared = ImaggaAPI()
  
  func postUpload(
    image: UIImage,
    progressCompletion: @escaping (_ percent: Float) -> Void,
    completion: @escaping (_ id: String?, _ tags: [String]?, _ colors: [ImageColor]?) -> Void) {
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
        self.getTags(imageID: uploadedImageID){
          tags in print("\(String(describing: tags))")
          self.getColors(imageID: uploadedImageID) {
            colors in print ("\(String(describing: colors))")
            completion(uploadedImageID, tags, colors)
          }
        }
        
      // error (400)
      case .failure(let error):
        print("Error while uploading file: \(String(describing: error))")
        completion(nil,nil,nil)
        
      }
    }
  }
  
  // getTags takes 2 arguments
  // an uploaded image id and a completion function that will be called
  // when we have received data from the Imagga API
  func getTags(imageID: String, completion: @escaping ([String]?) -> Void) {
    AF
      .request(ImaggaRouter.tags(imageID))
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          // success!
          // get the tags from the response
          let tags = JSON(value)["result"]["tags"].array?.map { json -> String in
            json["tag"]["en"].stringValue
          }
          
          // call the completion function and pass the tags
          completion(tags)
        case .failure(let error):
          print("Error while fetching tags: \(String(describing: error))")
          completion(nil)
        }
      }
  }
  
  // getColors takes 2 arguments
  // an uploaded image id and a completion function that will be called
  // when we have received data from the Imagga API
  func getColors(imageID: String, completion: @escaping ([ImageColor]?) -> Void) {
    AF
      .request(ImaggaRouter.colors(imageID))
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          // success!
          // get the tags from the response
          let photocolors = JSON(value)["result"]["colors"]["image_colors"].array?.map { json -> ImageColor in
            ImageColor(red:  json["r"].intValue,
                       green: json["g"].intValue,
                       blue: json["b"].intValue,
                       colorName: json["closest_palette_color"].stringValue)
          }
          
          // call the completion function and pass the tags
          completion(photocolors)
        case .failure(let error):
          print("Error while fetching colors: \(String(describing: error))")
          completion(nil)
        }
      }
  }
  
  
}

