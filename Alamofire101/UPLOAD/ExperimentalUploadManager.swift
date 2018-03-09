//StuckwithUpload

    
    var multipartFormData = MultipartFormData()
    let parameters: Parameters = ["photo": "swift_file.jpg"]
    
    let key = "photo"
    let value = "swift_file.jpg"
    
    //test function
    class func upload(_ router: Router,
                      file: Data,
                      parameters: Parameters,
                      multipartFormData: MultipartFormData,
                      successHandler: @escaping (JSON, ServerReplyCode) -> Void,
                      errorHandler: @escaping (Error)->Void = errorAction){
        print(serverHeaders)
        do{
            
            var urlRequest = try router.asURLRequest()
            
            if let body = urlRequest.httpBody{
                let bodyString = String(data: body, encoding: String.Encoding.utf8)!
                var bodyDict = [String: Any]()
                
                for keyValueString in bodyString.components(separatedBy: "&"){
                    var parts = keyValueString.components(separatedBy: "=")
                    
                    if parts.count < 2 { continue }
                    
                    let key = parts[0].removingPercentEncoding!
                    let value = parts[1].removingPercentEncoding!
                    
                    bodyDict[key] = value
                }
            }
            
            var loadingIndicator: LoadingIndicatorView?
            
            if router.route.waitUntilFinished {
                loadingIndicator = LoadingIndicatorView()
                UIApplication.shared.keyWindow!.addSubview(loadingIndicator!)
            }
            
            Alamofire.upload(
                multipartFormData: { MultipartFormData in
                    MultipartFormData.append(file, withName: "fileset", mimeType: "image/jpg")
                    for (key, value) in parameters {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                },
                to: "http://10.10.10.30:80/gba-webservice-1.0/images",
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):

                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                        })

                        upload.responseJSON { response in
                            debugPrint("SUCCESS", response)

                        }
                    case .failure(let error):
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        debugPrint(error as Any)
                        print("===========================\n\n")
                    }

                    if let loadingIndicator = loadingIndicator {
                        loadingIndicator.removeFromSuperview()
                    }
                }
            )
            
        }catch{
            errorHandler(error)
        }
        
    }
