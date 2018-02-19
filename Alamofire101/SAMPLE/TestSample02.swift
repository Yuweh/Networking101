//    func savePhoto(){
        let imageData = UIImageJPEGRepresentation(img.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        //self.dismiss(animated: true, completion: nil)
        print(imageData)
        self.photoSubmitted(imageData: imageData!)
    }


//Presenter
    func uploadProfilePicture(image: MultipartFormData){
        guard let bridge = dataBridge else { fatalError("dataBridge was not implemented in ContactSupportPresenter") }
        self.interactor.remote.uploadProfilePicture(form: image, successHandler: {
            (reply, statusCode) in
            print(reply)
            print(statusCode)
            
            switch statusCode{
            case .fetchSuccess:
                guard let message = reply["message"] as? String else{
                    fatalError("message not found in server reply: [\(reply)]")
                }
                bridge.didReceiveResponse(code: "\(message)")
                
                
            case .notModified:
                guard let message = reply["message"] as? String else{
                    fatalError("message not found in server reply: [\(reply)]")
                }
                self.wireframe.navigate(to: .ProfileView)
                bridge.didReceiveResponse(code: "\(message)")
                
                
            case .badRequest:
                guard let messages = reply["message"] as? [String:Any] else{
                    fatalError("Message not found")
                }
                
                var message: String?
                
                messages.forEach{
                    message = ($0.value as? [String])?.first
                    return
                }
                self.showAlert(with: "Message", message: message ?? "message not found", completion: { () })
            default: break
            }
        })
    }


//BASE
//            Alamofire.upload(
//                multipartFormData: { multipartFormData },
//                to: "\(router.baseComponent)/images",
//                encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .success(let upload, _, _):
//
//                        upload.uploadProgress(closure: { (Progress) in
//                            print("Upload Progress: \(Progress.fractionCompleted)")
//                        })
//
//                        upload.responseJSON { response in
//                            debugPrint("SUCCESS", response)
//
//                        }
//                    case .failure(let error):
//                        print("\n\n===========Error===========")
//                        print("Error Code: \(error._code)")
//                        print("Error Messsage: \(error.localizedDescription)")
//                        debugPrint(error as Any)
//                        print("===========================\n\n")
//                    }
//
//                    if let loadingIndicator = loadingIndicator {
//                        loadingIndicator.removeFromSuperview()
//                    }
//                }
//            )


//Applied at NetworkManager

    //test function
    class func upload(_ router: Router,
                      multipartFormData: @escaping (MultipartFormData) -> Void,
                      successHandler: @escaping (JSON, ServerReplyCode) -> Void,
                      errorHandler: @escaping (Error)->Void = errorAction){
        print(serverHeaders)
        do{
            
            var urlRequest = try router.asURLRequest()
            
            if let body = urlRequest.httpBody{
                let bodyString = String(data: body, encoding: String.Encoding.utf8)!
                var bodyDict = [String: String]()
                
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
        }catch{
            errorHandler(error)
        }
        
    }
