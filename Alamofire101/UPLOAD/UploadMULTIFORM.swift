//working (Swift 3 / Alamofire 4) code. Few global variables in there but you get the point i guess.

func uploadImage(_ imageFileName: String) {


        if let imageData = try? Data(contentsOf: localFolder.images.appendingPathComponent(imageFileName)) {
            let parameters = ["imageFileName":imageFileName, "userID":UD.userID!]
            let URL = serverURL.appendingPathComponent("image_upload.php")

            Alamofire.upload(multipartFormData: {
                multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")

                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }

                }, to: URL.absoluteString, method: .post
                ,encodingCompletion: {
                    encodingResult in

                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString { response in

                            switch response.result {
                            case .failure(let err):
                                printError("image upload failed: \(err)")
                                break
                            case .success(let str):
                                if str == "error" {
                                        printError("image upload failed. check server logs")
                                }
                                else {
                                        print("image upload successfull")
                                }
                            }

                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            })
        }

    }
