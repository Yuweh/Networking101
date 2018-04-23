func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
    
    let url = "http://google.com" /* your API url */
    
    let headers: HTTPHeaders = [
        /* "Authorization": "your_access_token",  in case you need authorization header */
        "Content-type": "multipart/form-data"
    ]
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        for (key, value) in parameters {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
        }
        
        if let data = imageData{
            multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
        }
        
    }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
        switch result{
        case .success(let upload, _, _):
            upload.responseJSON { response in
                print("Succesfully uploaded")
                if let err = response.error{
                    onError?(err)
                    return
                }
                onCompletion?(nil)
            }
        case .failure(let error):
            print("Error in upload: \(error.localizedDescription)")
            onError?(error)
        }
    }
}
