
func handleProfilePicker() {
let picker = UIImagePickerController()
picker.delegate = self
picker.allowsEditing = true
....(your custom code for navigationBar in Picker color)
self.present(picker,animated: true,completion: nil)
}


func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  var selectedImage: UIImage?
  if let editedImage = info["UIImagePickerControllerEditedImage"]   as? UIImage {
  selectedImage = editedImage
  } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
  selectedImage = originalImage
  }
  if let selectedImages = selectedImage {
  ....
  }
}



//

if let data = UIImageJPEGRepresentation(selectedImages,1) {
}

//CODE BLOCK

if let data = UIImageJPEGRepresentation(selectedImages,1) {
   let parameters: Parameters = [
   "access_token" : "YourToken"
   ]
   // You can change your image name here, i use NSURL image and convert into string
   let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
   let fileName = imageURL.absouluteString
   // Start Alamofire
   Alamofire.upload(multipartFormData: { multipartFormData in 
   for (key,value) in parameters {
        multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
   }
   multipartFormData.append(data, withName: "avatar", fileName: fileName!,mimeType: "image/jpeg")
  },
  usingTreshold: UInt64.init(),
  to: "YourURL",
  method: .put,
  encodingCompletion: { encodingResult in 
  switch encodingResult {
    case .success(let upload, _, _):
          upload.responJSON { response in
          debugPrint(response)
          }
    case .failure(let encodingError):
         print(encodingError)
    }
  })
 }
