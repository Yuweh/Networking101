

//

// import Alamofire
    func uploadWithAlamofire() {
        
        let image = self.profile_imageView.image!
        let parameters: Parameters = ["is_profile":"true"]
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key,value) in parameters {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key )
                }
        },
            to: "http://10.10.10.30:80/gba-webservice-1.0/images",
            method: .post,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        debugPrint("SUCCESS ", response)
                        
                    }
                case .failure(let error):
                    print("\n\n===========Error===========")
                    print("Error Code: \(error._code)")
                    print("Error Messsage: \(error.localizedDescription)")
                    debugPrint(error as Any)
                    print("===========================\n\n")
                }
        }
        )
    }
