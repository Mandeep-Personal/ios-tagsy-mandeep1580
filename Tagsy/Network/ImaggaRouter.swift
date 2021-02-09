import Alamofire

public enum ImaggaRouter: URLRequestConvertible {
  
  case upload
  case tags(String)
  case colors(String)
  
  enum Constants {
    
    static let baseURL = "https://api.imagga.com/v2"
    static let authorizationToken = "Basic YWNjX2Y2ODI3MDUxOTUxYzlhZjpkYTE2Y2Y2ODU3YzYwNTUxN2QzMjI5NTU3Njg2NzQ2ZQ=="
  }
  
  var method: HTTPMethod {
    switch self {
    case .upload: return .post
    case .tags, .colors: return .get
    }
  }
  
  var path: String {
    switch self {
    case .upload: return "/uploads"
    case .tags: return "/tags"
    case .colors: return "/colors"
    }
  }
  
  var parameters: [String: Any] {
    switch self {
    case .tags(let contentID): return ["image_upload_id": contentID]
    case .colors(let contentID): return ["image_upload_id": contentID, "extract_object_colors": 0]
    default: return [:]
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try Constants.baseURL.asURL()
    var request = URLRequest(url: url.appendingPathComponent(path))
    request.httpMethod = method.rawValue
    request.setValue(Constants.authorizationToken, forHTTPHeaderField: "Authorization")
    
    return try URLEncoding.default.encode(request, with: parameters)
  }

}
