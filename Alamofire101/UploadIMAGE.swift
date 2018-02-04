//UploadIMAGE.swift

//Convert UIImage to Data, here is a snippet that can help you:
let img = UIImage(named:"someImage.png")
let data = UIImageJPEGRepresentation(img, 1.0)

//What is coded :D

    func savePhoto(){
        let imageData = UIImageJPEGRepresentation(img.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        self.dismiss(animated: true, completion: nil)
    }

    // import Alamofire
    func uploadWithAlamofire() {
         
         
         
         //this could be sent by DataBridge and thru Form + Struct >? or Func uploadProfileImage(image: UIImage) :D
        let image = sendImage.image!
        
        
        //could set a direct approach for this
        Alamofire.upload(
        
            multipartFormData: { multipartFormData in
                
                if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                    multipartFormData.append(imageData, withName: "uploadedImage", fileName: "\(self.id!)_\(Timestamp).png", mimeType: "image/png")
                }
            },
            to: "\(Constants.productionServerLocal)/api/kyc/\(id!)/upload/kycselfphoto/uploadImageMobile",
            encodingCompletion: { encodingResult in
                
                
                switch encodingResult {
                case .success(let upload, _, _):
                   
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
         
                    upload.responseJSON { response in
                        debugPrint(response)
                        
                        //
                        userPoint.requestForState(self)
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.SuccessfullySubmittedSelfieViewControllerID) as! SuccessfullySubmittedSelfieViewController
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
    
